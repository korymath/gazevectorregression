% conditions can be set by using the following flags:
% 'all': all data
% 'sweep': sweep data
% 'grid': grid data
% 'fixed': head fixed data
% 'free': head free data
% 'task': task data

exp_var.trainStr = 'A12_CalibC_E_01_combined_calNum1';
exp_var.testStr = 'A12_CalibC_E_01_combined_calNum1';

segments = {'all','free','fixed','task'};
N = length(segments);

errMean = zeros(N,N);
errStd = zeros(N,N);
errDistErr = cell(N,N);

errDistVec = [];
errDistLen = [];

k = 0;

for i = 1:length(segments)
    for j = 1:length(segments)
        
        % Define experiment for all on all
        exp_var.trainCond = segments{i};
        exp_var.testCond = segments{j};
        exp_var.expStr = strcat(exp_var.trainStr,'_',exp_var.trainCond,'_on_',...
            exp_var.testStr,'_',exp_var.testCond);
        errors = exp_wrap(exp_var);
        
        errMean(i,j) = errors.meanErr;
        errStd(i,j) = errors.stddevErr;
        errDistErr{i,j} = errors.distErr/10;
        
        errDistVec = [errDistVec; errDistErr{i,j}];
        errDistLen = [errDistLen, k*ones(1,length(errDistErr{i,j}))];
        
        k = k + 1
    end
end

%% Build some nice figures from the experiment
figure;
boxplot(errDistVec,errDistLen,'Notch','on')

