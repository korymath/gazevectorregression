function [trainSet,testSet,errors] = testModelCart(expStr)

% Get the Training Set and Trained Model
if ~exist('trainSet','var')
    trainStr = ['trainSet_' expStr];
    trainSet = load([pwd '/data/proc/' trainStr '.mat']);
end

% Get the Testing Set
if ~exist('testSet','var')
    testStr = ['testSet_' expStr];
    testSet = load([pwd '/data/proc/' testStr '.mat']);
end

testSet.predPos = zeros(size(testSet.trueMarker));
testSet.predPosFilt = zeros(size(testSet.trueMarker));

% Get the predicted positions of the marker tip (focus point) in head space
for i=1:3
    % Predict the testing set with the trained model
    testSet.predPos(:,i) = predict(trainSet.mdl{i},testSet.eyeData);
    
    % smooth things out
    testSet.predPosFilt(:,i) = hampel(testSet.predPos(:,i),150);
end

% Hacky solution to make sure the transformation matrix exists for each
% time step. TODO: Why doesn't it exist for the first time point? 
% at least it helped me see the issue with the offset indexing
testSet.tM(:,:,1) = testSet.tM(:,:,2);
testSet.offset(:,1) = testSet.offset(:,2);

testSet.regFixPoints = transform_head_to_vicon(testSet.predPosFilt,testSet.tM,testSet.offset);

% Mean Squared Error
errors.MSEXerr = nanmean((testSet.regFixPoints(:,1) - testSet.trueMarker(:,1)).^2);
errors.MSEYerr = nanmean((testSet.regFixPoints(:,2) - testSet.trueMarker(:,2)).^2);
errors.MSEZerr = nanmean((testSet.regFixPoints(:,3) - testSet.trueMarker(:,3)).^2);

% Root MSE
errors.RMSEX = sqrt(errors.MSEXerr);
errors.RMSEY = sqrt(errors.MSEYerr);
errors.RMSEZ = sqrt(errors.MSEZerr);

% Normalized RMSE
errors.NRMSEX = 100*sqrt(errors.MSEXerr)/(max(testSet.trueMarker(:,1))-min(testSet.trueMarker(:,1)));
errors.NRMSEY = 100*sqrt(errors.MSEYerr)/(max(testSet.trueMarker(:,2))-min(testSet.trueMarker(:,2)));
errors.NRMSEZ = 100*sqrt(errors.MSEZerr)/(max(testSet.trueMarker(:,3))-min(testSet.trueMarker(:,3)));

% Calculate error in distance at every point
errors.distErr = sqrt(((testSet.regFixPoints(:,1) - testSet.trueMarker(:,1)).^2) + ...
    ((testSet.regFixPoints(:,2) - testSet.trueMarker(:,2)).^2) + ...
    ((testSet.regFixPoints(:,3) - testSet.trueMarker(:,3)).^2));

% This provides the mean error in CM.
errors.meanErr = nanmean(errors.distErr)/10;

% make a prediction figure
makefig_prediction_cart(testSet.trueMarker,testSet.regFixPoints)

% Make an error figure in CM
makefig_error_cart(errors.distErr/10,errors.meanErr)

filename = [pwd '/data/proc/output_' expStr '.csv'];

fid = fopen(filename, 'w');
fprintf(fid, 'fitPtX \t fitPtY \t fitPtZ \t LeftPupil_X \t LeftPupil_Y \t RightPupil_X \t RightPupil_Y \n');
fclose(fid);

dlmwrite(filename, [testSet.regFixPoints testSet.eyeData], '-append', 'precision', '%.6f', 'delimiter', '\t');

end