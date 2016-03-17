function [ errors ] = exp_wrap( exp_var )
%EXP_WRAP This function wraps experiments for batch processing
    % It allows for some basic command line scripting for the functions
    
trainStr = exp_var.trainStr;
testStr = exp_var.testStr;
expStr = exp_var.expStr;
trainCond = exp_var.trainCond;
testCond = exp_var.testCond;
    
% Load training data
[eyeData,markerData,tM,offset,trueMarker,details] = collect_data({trainStr},trainStr(1:3),trainCond);

% Build a model
[predPos,predPosFilt,mdl] = build_models(eyeData,markerData);
fitPoints = transform_head_to_vicon(predPosFilt,tM,offset);
save([pwd '/data/proc/trainSet_' expStr '.mat']);
clearvars -global -except trainStr testStr expStr

% Load testing data
[eyeData,markerData,tM,offset,trueMarker,details] = collect_data({testStr},testStr(1:3),testCond);
save([pwd '/data/proc/testSet_' expStr '.mat']);

% run testing on test set
[trainSet,testSet,errors] = test_model(expStr);

end

