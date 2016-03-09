function [trainSet,testSet,errors] = testModelCart(expStr)

% Get the Training Set and Trained Model
if ~exist('trainSet')
    trainStr = ['trainSetA16_' expStr];
    trainSet = load([pwd '/TestingA16/' trainStr '.mat']);
end

% Get the Testing Set
if ~exist('testSet')
    testStr = ['testSetA16_' expStr];
    testSet = load([pwd '/TestingA16/' testStr '.mat']);
end

testSet.predPos = zeros(size(testSet.trueMarker));
testSet.predPosFilt = zeros(size(testSet.trueMarker));

% Get the predicted positions of the marker tip (focus point) in head space
for i=1:3
    % Predict the testing set with the trained model
    testSet.predPos(:,i) = predict(trainSet.mdl{i},normAndClean(testSet.eyeData));
    
    % smooth things out
    testSet.predPosFilt(:,i) = hampel(testSet.predPos(:,i),150);
end

% Hacky solution to make sure the transformation matrix exists for each
% time step. TODO: Why doesn't it exist for the first time point? 
% at least it helped me see the issue with the offset indexing
testSet.tM(:,:,1) = testSet.tM(:,:,2);
testSet.offset(:,1) = testSet.offset(:,2);

testSet.regFixPoints = transformHEADtoVICON(testSet.predPosFilt,testSet.tM,testSet.offset);

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

% figure;
% plot(errors.distErr/10,'LineWidth',2);
% hold on; plot(errors.meanErr*ones(1,length(errors.distErr)),'r-','LineWidth',4);
% % axis([0 inf 0 100]);
% title('Error vs. Sample Number', 'FontSize', 24);
% ylabel('Distance Error (cm)', 'FontSize', 24);
% xlabel('Sample Number', 'FontSize', 24);

filename = [pwd '/TestingA16/testA16_output' expStr '.csv'];

fid = fopen(filename, 'w');
fprintf(fid, 'fitPtX \t fitPtY \t fitPtZ \t LeftPupil_X \t LeftPupil_Y \t RightPupil_X \t RightPupil_Y \n');
fclose(fid);

dlmwrite(filename, [testSet.regFixPoints testSet.eyeData], '-append', 'precision', '%.6f', 'delimiter', '\t');

end