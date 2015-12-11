function [predPos,mdl] = calcPos(X,Y)

XnormClean = normAndClean(X); 

% find the good indexes to train the model on
% when the sum of absolute values of the derivates is less than
% a given threshold then this is a good training index
absSumDiff = sum(abs(diff(XnormClean)),2);
goodIDX = find(absSumDiff<mean(absSumDiff));

% Build the good model
mdl = fitlm(XnormClean(goodIDX,:),Y(goodIDX,:)); 
% mdl = fitlm(XnormClean(goodIDX,:),Y(goodIDX,:),'quadratic','RobustOpts','on');

% mdl = fitrsvm(XnormClean(goodIDX,:),Y(goodIDX,:),'Standardize',true,...
%    'CacheSize','maximal','Verbose',1,'NumPrint',500,'Epsilon',0.1);

% t = templateTree('MaxNumSplits',512,'Surrogate','on');
% mdl = fitensemble(XnormClean(goodIDX,:),Y(goodIDX,:),'LSBoost',100,t,'type','regression');

% mdl = fitrsvm(XnormClean(goodIDX,:),Y(goodIDX,:),'Standardize',true,'ShrinkagePeriod',2000,...
%     'CacheSize','maximal','Verbose',1,'NumPrint',2000,...
%     'KernelFunction','gaussian','Solver','SMO','ClipAlphas',true,...
%     'Epsilon',0.3,'KernelScale','auto');

% mdl = fitrgp(XnormClean(goodIDX,:),Y(goodIDX,:),'Verbose',1);

% predict the positions using the given model
predPos = predict(mdl,XnormClean);   




% mdl = fitrsvm(X(goodIDX,:),Y(goodIDX,:),'Standardize',true,'CacheSize','maximal',...
%     'Verbose',1,'NumPrint',1000,'KernelScale','auto',...
%     'Solver','SMO','GapTolerance',1e-3,'Epsilon',15);

% mdl = fitrgp(XnormClean(goodIDX,:),Y(goodIDX,:),'Verbose',1);

% mdl = fitrsvm(X(goodIDX,:),Y(goodIDX,:),'Standardize',true,'ShrinkagePeriod',2000,...
%     'CacheSize','maximal','Verbose',1,'NumPrint',2000,...
%     'KernelFunction','gaussian','Solver','SMO','ClipAlphas',true,...
%     'Epsilon',0.3,'KernelScale','auto');
% 
% mdl = fitrsvm(X(goodIDX,:),Y(goodIDX,:),'Standardize',true,'ShrinkagePeriod',2000,...
%     'CacheSize','maximal','Verbose',1,'NumPrint',2000,...
%     'KernelFunction','gaussian','Solver','SMO','ClipAlphas',true,...
%     'Epsilon',0.3,'KernelScale','auto');

% mdl = fitlm(X(goodIDX,:),Y(goodIDX,:),'quadratic','RobustOpts','on');

% t = templateTree('MaxNumSplits',512,'Surrogate','on');
% mdl = fitensemble(X(goodIDX,:),Y(goodIDX,:),'LSBoost',100,t,'type','regression');

% mdl = fitrsvm(X,Y,'Standardize',true,...
%     'CacheSize','maximal','Verbose',1,'NumPrint',500,'Epsilon',0.1);

end





