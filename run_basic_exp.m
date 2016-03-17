% conditions can be set by using the following flags:
% 'all': all data
% 'sweep': sweep data
% 'grid': grid data
% 'fixed': head fixed data
% 'free': head free data
% 'task': task data

exp_var.trainStr = 'A12_CalibC_E_01_combined_calNum1';
exp_var.testStr = 'A12_CalibC_E_01_combined_calNum1';

% Define experiment for all on all
exp_var.trainCond = 'all';
exp_var.testCond = 'all';
exp_var.expStr = strcat(exp_var.trainStr,'_',exp_var.trainCond,'_on_',...
    exp_var.testStr,'_',exp_var.testCond);
errorsAll = exp_wrap(exp_var);

% Define experiment for all on all
exp_var.trainCond = 'fixed';
exp_var.testCond = 'fixed';
exp_var.expStr = strcat(exp_var.trainStr,'_',exp_var.trainCond,'_on_',...
    exp_var.testStr,'_',exp_var.testCond);
errorsFixed = exp_wrap(exp_var);

% Define experiment for all on all
exp_var.trainCond = 'free';
exp_var.testCond = 'free';
exp_var.expStr = strcat(exp_var.trainStr,'_',exp_var.trainCond,'_on_',...
    exp_var.testStr,'_',exp_var.testCond);
errorsFree = exp_wrap(exp_var);


