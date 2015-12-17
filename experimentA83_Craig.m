% experimentA83 

expStr = 'A83_CalibC_B_01_on_A83_Cups_B_01_NEWTEST';

% % Load training data
% [eyeData,markerData,tM,offset,trueMarker] = collectData({'A83_CalibP_B_01'});
% % Build a model
% [predPos,predPosFilt,mdl] = calcGazeCart(eyeData,markerData);
% save([pwd '/TestingA83/trainSetA83_' expStr '.mat']);
% clear global -except expStr;
% 
% % Load testing data
% [eyeData,markerData,tM,offset,trueMarker] = collectData({'A83_CalibP_B_01'}); % A83_Pasta_B_02
% % Build a model
% % [predPos,predPosFilt,mdl] = calcGazeCart(eyeData,markerData);
% save([pwd '/TestingA83/testSetA83_' expStr '.mat']);
% clear global -except expStr;

% run testing on test set
[trainSet,testSet,errors] = testModelCartA83(expStr);

% Load the cleaned data from Craigs wor
craigTrain = load([pwd '/TestingA83/craig/A_83_CalibP_B_1_Clean.mat']);

% left x,y then right x,y
craigTrain.eyeData = [craigTrain.lxpnifd; craigTrain.lypnifd;...
    craigTrain.rxpnifd; craigTrain.rypnifd]';

% resample to handle the aliasing and offshoot at the endpoints
craigTrain.markerData = resample(trainSet.markerData,...
    length(craigTrain.eyeData),length(trainSet.markerData),2);

craigTest = load([pwd '/TestingA83/craig/A_83_CalibP_B_1_Clean.mat']);
% load([pwd '/TestingA83/craig/A_83_Pasta_B_2_Clean.mat']);

craigTest.eyeData = [craigTest.lxpnifd; craigTest.lypnifd;...
    craigTest.rxpnifd; craigTest.rypnifd]';

% resample to handle the aliasing and offshoot at the endpoints
craigTest.markerData = resample(testSet.markerData,...
    length(craigTest.eyeData),length(testSet.markerData),2);

[craigTrain.predPos,craigTrain.predPosFilt,craigTrain.mdl] = ...
    calcGazeCart(craigTrain.eyeData,craigTrain.markerData);

% Check the correlation between the matrices
[r,p]=corr(craigTrain.eyeData,craigTrain.markerData,'rows','complete');

% Test the model on the testing data
craigTest.predPos = zeros(size(craigTest.markerData));

% Get the predicted positions of the marker tip (focus point) in head space
for i=1:3
    % Predict the testing set with the trained model
    craigTest.predPos(:,i) = predict(craigTrain.mdl{i},normAndClean(craigTest.eyeData)); 
end

upsampRegFix = resample(craigTest.predPos,length(testSet.offset),length(craigTest.predPos));

% convert the points back to the world coordinate system
craigTest.regFixPoints = transformHEADtoVICON(upsampRegFix,testSet.tM,testSet.offset);

craigTest.finalFit = resample(craigTest.regFixPoints,length(craigTest.markerData),length(craigTest.regFixPoints));
craigTest.trueMarkerFinal = resample(testSet.trueMarker,length(craigTest.markerData),length(testSet.trueMarker));

craigTest.distErr = sqrt(((craigTest.finalFit(:,1) - craigTest.trueMarkerFinal(:,1)).^2) + ...
    ((craigTest.finalFit(:,2) - craigTest.trueMarkerFinal(:,2)).^2) + ...
    ((craigTest.finalFit(:,3) - craigTest.trueMarkerFinal(:,3)).^2));

figure;
plot(craigTest.distErr/10,'LineWidth',2);
hold on; plot(craigTest.distErr*ones(1,length(craigTest.distErr)),'r-','LineWidth',4);
% axis([0 inf 0 100]);
title('Error vs. Sample Number', 'FontSize', 24);
ylabel('Distance Error (cm)', 'FontSize', 24);
xlabel('Sample Number', 'FontSize', 24);

nanmean(craigTest.distErr)/10

% errors.meanErr

% compare the true marker points and the regressed point
makePredFigCartA83(testSet.trueMarker,craigTest.regFixPoints);

% combine into an output file and write to csv
outputPoints = testSet.regFixPoints;
csvwrite([pwd '/TestingA83/testA83_output' expStr '.csv'],outputPoints);





