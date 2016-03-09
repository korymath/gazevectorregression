% experimentA12

trainStr = 'A12_CalibC_B_01_combined';
testStr = 'A12_CalibC_B_01_combined';
expStr = strcat(trainStr,'_on_',testStr);

% Load training data
[eyeData,markerData,tM,offset,trueMarker] = collect_data({trainStr},trainStr(1:3));

% Build a model
[predPos,predPosFilt,mdl] = build_models(eyeData,markerData);
fitPoints = transform_head_to_vicon(predPosFilt,tM,offset);
save([pwd '/data/proc/trainSet_' expStr '.mat']);
clearvars -global -except trainStr testStr expStr

% Load testing data
[eyeData,markerData,tM,offset,trueMarker] = collect_data({testStr},testStr(1:3));
save([pwd '/data/proc/testSet_' expStr '.mat']);

% run testing on test set
[trainSet,testSet,errors] = test_model(expStr);
