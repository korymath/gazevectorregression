function [ errors ] = get_error_measures(predPoints, actualPoints)
%GET_ERROR_MEASURES This function gets the error measures based on
%predicted and actual points

% Mean Squared Error
errors.MSEXerr = nanmean((predPoints(:,1) - actualPoints(:,1)).^2);
errors.MSEYerr = nanmean((predPoints(:,2) - actualPoints(:,2)).^2);
errors.MSEZerr = nanmean((predPoints(:,3) - actualPoints(:,3)).^2);

% Root MSE
errors.RMSEX = sqrt(errors.MSEXerr);
errors.RMSEY = sqrt(errors.MSEYerr);
errors.RMSEZ = sqrt(errors.MSEZerr);

% Normalized RMSE
errors.NRMSEX = 100*sqrt(errors.MSEXerr)/(max(actualPoints(:,1))-min(actualPoints(:,1)));
errors.NRMSEY = 100*sqrt(errors.MSEYerr)/(max(actualPoints(:,2))-min(actualPoints(:,2)));
errors.NRMSEZ = 100*sqrt(errors.MSEZerr)/(max(actualPoints(:,3))-min(actualPoints(:,3)));

% Calculate error in distance at every point
errors.distErr = sqrt(((predPoints(:,1) - actualPoints(:,1)).^2) + ...
    ((predPoints(:,2) - actualPoints(:,2)).^2) + ...
    ((predPoints(:,3) - actualPoints(:,3)).^2));

% This provides the mean error in CM.
errors.meanErr = nanmean(errors.distErr)/10;
errors.stddevErr = nanstd(errors.distErr)/10;


end

