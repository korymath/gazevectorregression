
exp_var.trainCond = 'all';
exp_var.testCond = 'all';
exp_var.expStr = 'test';
exp_var.testStr = 'A12_CalibC_B_01_combined_calNum3.mat';
exp_var.trainStr = 'A12_CalibC_B_01_combined_calNum3.mat';

[ errors, calType ] = exp_wrap( exp_var );
