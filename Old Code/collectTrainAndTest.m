% Experimental test on the new data format

function [trainSet,testSet] = collectTrainAndTest(expStr)

% Get the Training Set and Trained Model
if ~exist('trainSet')
    trainStr = [expStr];
    trainSet = load([pwd '/data/' trainStr '.mat']);
end

% Get the Testing Set
if ~exist('testSet')
    testStr = [expStr];
    testSet = load([pwd '/data/' testStr '.mat']);
end

end