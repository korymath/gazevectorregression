% experimentA16 

expStr = 'A16_CalibP_B_01_on_Pasta';
% expStr = 'A16_CalibP_B_01_on_itself';

% Load training data
[eyeData,markerData,tM,offset,trueMarker] = collectDataA16({'A16_CalibP_B_01_coReg'});
% Build a model
[predPos,predPosFilt,mdl] = calcGazeCart(eyeData,markerData);
fitPoints = transformHEADtoVICON(predPosFilt,tM,offset);
save([pwd '/TestingA16/trainSetA16_' expStr '.mat']);
fig = makePredFigCartA83(trueMarker,fitPoints);
clear global -except expStr;
close all;

% Load testing data

% On itself
% [eyeData,markerData,tM,offset,trueMarker] = collectDataA16({'A16_CalibP_B_01_coReg'});

% On new pasta task
[eyeData,markerData,tM,offset,trueMarker] = collectDataA16({'A16_Pasta_B_01_coReg'});

% Build a model
% [predPos,predPosFilt,mdl] = calcGazeCart(eyeData,markerData);
% fitPoints = transformHEADtoVICON(predPosFilt,tM,offset);
save([pwd '/TestingA16/testSetA16_' expStr '.mat']);
% fig = makePredFigCartA83(trueMarker,fitPoints);
clear global -except expStr;

% run testing on test set
[trainSet,testSet,errors] = testModelCartA16(expStr);

% Show the firt in world coordinates
% fig = makePredFigCartA83(testSet.trueMarker,testSet.regFixPoints);

% Done!

