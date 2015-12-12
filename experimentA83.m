% experimentA83 

expStr = 'test1_robust';

% Load training data
[eyeData,markerData,tM,offset,trueMarker] = collectData({'A83_CalibC_B_01'});
% Build a model
[predPos,predPosFilt,mdl] = calcGazeCart(eyeData,markerData);
save([pwd '/TestingA83/trainSetA83_' expStr '.mat']);
clear global -except expStr;

% Load testing data
[eyeData,markerData,tM,offset,trueMarker] = collectData({'A83_CalibC_B_01'});
% Build a model
[predPos,predPosFilt,mdl] = calcGazeCart(eyeData,markerData);
save([pwd '/TestingA83/testSetA83_' expStr '.mat']);
clear global -except expStr;

% run testing on test set
[trainSet,testSet,errors] = testModelCartA83(expStr);

eyes = hampel(trainSet.eyeData,10);
justX = trainSet.markerData(:,1);

% build the Neural Network with the testing data
% A83_nn_testing

% predict the fixation point given the testing eye data
% newY = net(testSet.eyeData');
% cleanPred = hampel(newY,10)';

% Calculate error in distance at every point
% newErr = sqrt(((cleanPred(:,1) - testSet.markerData(:,1)).^2) + ...
%     ((cleanPred(:,2) - testSet.markerData(:,2)).^2) + ...
%     ((cleanPred(:,3) - testSet.markerData(:,3)).^2));

% makePredFigCartA83(testSet.markerData,cleanPred);

% This provides the mean error in CM.
% NNerror = mean(newErr)/10

errors.meanErr

% compare the true marker points and the regressed point
makePredFigCartA83(testSet.trueMarker,testSet.regFixPoints);

% combine into an output file and write to csv
outputPoints = [testSet.trueMarker testSet.regFixPoints];
csvwrite([pwd '/TestingA83/testA83_output' expStr '.csv'],outputPoints);





