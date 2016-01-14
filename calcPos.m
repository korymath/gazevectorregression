function [predPos,mdl] = calcPos(X,Y)

% find the good indexes to train the model on
% when the sum of absolute values of the derivates is less than
% a given threshold then this is a good training index
% absSumDiff = sum(abs(diff(X)),2);
% goodIDX = find(absSumDiff<0.05*mean(absSumDiff));
% goodIDX = find(absSumDiff<100*mean(absSumDiff));

% Build the good model
% mdl = fitlm(X,Y,'quadratic'); 
% mdl = fitglm(X,Y,'quadratic','distr','normal'); 
% mdl = fitlm(X(goodIDX,:),Y(goodIDX,:)); 
mdl = fitlm(X,Y,'quadratic','RobustOpts','on');

% mdl = fitrsvm(X,Y,'Standardize',true,...
%    'CacheSize','maximal','Verbose',1,'NumPrint',500,'Epsilon',0.1);

% t = templateTree('Surrogate','On');
% mdl = fitensemble(X,Y,'LSBoost',1000,t,'type','regression');

% mdl = fitrgp(X,Y,'Verbose',1); %,'ComputationMethod','v','FitMethod','exact','PredictMethod','exact');

% mdl = fitrtree(X(goodIDX,:),Y(goodIDX,:));

% mdl = fitrsvm(X,Y,'Standardize',true,...
%     'CacheSize','maximal','Verbose',1,...
%     'KernelFunction','gaussian','Solver','SMO',...
%     'ClipAlphas',false,'ShrinkagePeriod',0,...
%     'Epsilon',0.1,'KernelScale','auto');

% t = templateTree('MaxNumSplits',10,'Surrogate','on');
% mdl = fitensemble(X(goodIDX,:),Y(goodIDX,:),'LSBoost',20,t,'type','regression','LearnRate',0.1);

% mdl = fitrgp(XnormClean(goodIDX,:),Y(goodIDX,:),'Verbose',1);

% predict the positions using the given model
predPos = predict(mdl,X);   

% mdl = fitrsvm(X(goodIDX,:),Y(goodIDX,:),'Standardize',true,'CacheSize','maximal',...
%     'Verbose',1,'NumPrint',1000,'KernelScale','auto',...
%     'Solver','SMO','GapTolerance',1e-3,'Epsilon',15);

% mdl = fitrgp(XnormClean(goodIDX,:),Y(goodIDX,:),'Verbose',1);

% mdl = fitrsvm(X(goodIDX,:),Y(goodIDX,:),'Standardize',true,'ShrinkagePeriod',2000,...
%     'CacheSize','maximal','Verbose',1,'NumPrint',2000,...
%     'KernelFunction','gaussian','Solver','SMO','ClipAlphas',true,...
%     'Epsilon',0.3,'KernelScale','auto');
% 

% mdl = fitlm(X(goodIDX,:),Y(goodIDX,:),'quadratic','RobustOpts','on');

% t = templateTree('MaxNumSplits',512,'Surrogate','on');
% mdl = fitensemble(X(goodIDX,:),Y(goodIDX,:),'LSBoost',100,t,'type','regression');

% mdl = fitrsvm(X,Y,'Standardize',true,...
%     'CacheSize','maximal','Verbose',1,'NumPrint',500,'Epsilon',0.1);

end





