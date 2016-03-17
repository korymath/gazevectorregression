% experimentA12

trainStr = 'A12_CalibC_E_01_combined_calNum1';
testStr = 'A12_CalibC_E_01_combined_calNum1';
expStr = strcat(trainStr,'_on_',testStr);

% Load training data
[eyeData,markerData,tM,offset,trueMarker,info] = collect_data({trainStr},trainStr(1:3));

% Some basic examples for finding indices groupings
% the info array defines the calibration type, head movement type, and
% calibration number.

details.sweepIdx = find(info(:,1) == 1);
details.gridIdx = find(info(:,1) == 2);

details.headfreeIdx = find(info(:,2) == 1);
details.headfixedIdx = find(info(:,2) == 2);
details.taskIdx = find(info(:,2) == 3);

details.cal1Idx = find(info(:,3) == 1);
details.cal2Idx = find(info(:,3) == 2);
details.cal3Idx = find(info(:,3) == 3);
details.cal4Idx = find(info(:,3) == 4);
details.cal5Idx = find(info(:,3) == 5);

% Build a model
[predPos,predPosFilt,mdl] = build_models(eyeData,markerData);
fitPoints = transform_head_to_vicon(predPosFilt,tM,offset);
save([pwd '/data/proc/trainSet_' expStr '.mat']);
clearvars -global -except trainStr testStr expStr

% Load testing data
[eyeData,markerData,tM,offset,trueMarker,info] = collect_data({testStr},testStr(1:3));
save([pwd '/data/proc/testSet_' expStr '.mat']);

% run testing on test set
[trainSet,testSet,errors] = test_model(expStr);

