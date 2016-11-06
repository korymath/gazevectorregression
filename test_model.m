function [trainSet,testSet,errors] = test_model(expStr)

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

testSet.regFixPoints = transform_head_to_vicon(testSet.predPosFilt,testSet.tM,testSet.offset);

% make a function to be able to get the errors from arbitrary in and out
% points, specifically it should be able to handle the head space
% coordinates 

% get the errors in the world coordinate system
errors = get_error_measures(testSet.regFixPoints,testSet.trueMarker);

% get the errors in the head coordinate system
errors.errorsHeadSpace = get_error_measures(testSet.predPosFilt,testSet.markerData);

% % make a prediction figure
makefig_prediction_cart(testSet.trueMarker,testSet.regFixPoints)
% 
% % Make an error figure in CM
makefig_error_cart(errors.distErr/10,errors.meanErr)
% 
% filename = [pwd '/data/proc/output_' expStr '.csv'];
% 
% fid = fopen(filename, 'w');
% fprintf(fid, 'fitPtX \t fitPtY \t fitPtZ \t LeftPupil_X \t LeftPupil_Y \t RightPupil_X \t RightPupil_Y \n');
% fclose(fid);
% 
% dlmwrite(filename, [testSet.regFixPoints testSet.eyeData], '-append', 'precision', '%.6f', 'delimiter', '\t');

end