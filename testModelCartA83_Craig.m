function [trainSet,testSet] = testModelCartA83_Craig(expStr)

% Get the Training Set and Trained Model
if ~exist('trainSet')
    trainStr = ['trainSetA83_' expStr];
    trainSet = load([pwd '/TestingA83/' trainStr '.mat']);
end

% Get the Testing Set
if ~exist('testSet')
    testStr = ['testSetA83_' expStr];
    testSet = load([pwd '/TestingA83/' testStr '.mat']);
end

end