
exp_var.trainCond = 'all';
exp_var.testCond = 'all';
exp_var.expStr = 'test';
exp_var.testStr = 'R12_CalibC_B_01_combined_segments.mat';
exp_var.trainStr = 'R12_CalibC_B_01_combined_segments.mat';

[ errors, calType ] = exp_wrap( exp_var );

%% Old outputs commented out
% % Length of the vectors in head space
% a = markerData(1,:);
% b = predPosFilt(1,:);
% 
% % Length of the true point vector
% norm(markerData(1,:));
% 
% % Length of the estimated point vector
% norm(predPosFilt(1,:));
% 
% % Projection of the estimated vector onto the true vector
% % will give us the estimated error in length and angle
% a*dot(a,b)/(norm(a)^2);
% 
% angle = atan2(norm(cross(a,b)),dot(a,b));
% angle_degrees = rad2deg(angle);

