function [ details ] = get_cal_info( info )
%GET_CAL_INFO Get the calibration information from the information columns
%   Some basic examples for finding indices groupings
%   the info array defines the calibration type, head movement type, and
%   calibration number.

% Calibration Type
details.sweepIdx = find(info(:,1) == 1);
details.gridIdx = find(info(:,1) == 2);
% Head Movement Type
details.headfreeIdx = find(info(:,2) == 1);
details.headfixedIdx = find(info(:,2) == 2);
details.taskIdx = find(info(:,2) == 3);
% Calibration Number
details.cal1Idx = find(info(:,3) == 1);
details.cal2Idx = find(info(:,3) == 2);
details.cal3Idx = find(info(:,3) == 3);
details.cal4Idx = find(info(:,3) == 4);
details.cal5Idx = find(info(:,3) == 5);

end

