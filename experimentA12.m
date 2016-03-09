% experimentA12

trainStr = 'A12_CalibC_B_01_combined';
testStr = 'A12_CalibC_B_01_combined';
expStr = strcat(trainStr,'_on_',testStr);

% Load training data
[eyeData,markerData,tM,offset,trueMarker] = collectDataA12({trainStr});

% Build a model
[predPos,predPosFilt,mdl] = calcGazeCart(eyeData,markerData);
fitPoints = transformHEADtoVICON(predPosFilt,tM,offset);
save([pwd '/data/TestingA12/trainSetA12_' expStr '.mat']);
fig = makePredFigCart(trueMarker,fitPoints);

% Load testing data
[eyeData,markerData,tM,offset,trueMarker] = collectDataA12({testStr});
save([pwd '/data/TestingA12/testSetA12_' expStr '.mat']);

% run testing on test set
[trainSet,testSet,errors] = testModelCartA16(expStr);

