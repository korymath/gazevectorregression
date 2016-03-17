% conditions can be set by using the following flags:
% 'all': all data
% 'sweep': sweep data
% 'grid': grid data
% 'fixed': head fixed data
% 'free': head free data
% 'task': task data

exp_var.trainStr = 'A12_CalibC_E_01_combined_calNum1';
exp_var.testStr = 'A12_CalibC_E_01_combined_calNum1';

segments = {'all','fixed','free','task'};
N = length(segments);

errMean = zeros(N,N);
errStd = zeros(N,N);
errDistErr = cell(N,N);

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
    end
end

%% Build some nice figures from the experiment
figure;
boxplot([errDistErr{1,1}],'Notch','on')

%%
c_1 = errDistErr{1,1};
c_2 = errDistErr{2,1};
c_3 = errDistErr{3,1};
c_4 = errDistErr{4,1};
C = [c_1 c_2 c_3 c_4];
n = ones(1,length(errDistErr{2,1}));
grp = [0*n,1*n,2*n,3*n];
figure;
boxplot(C,grp,'Notch','on');


