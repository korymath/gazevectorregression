function XnormClean = normAndClean(X)
% normalize and standardize the input features
%     [XnormClean, ~, ~] = featureNormalize(X);

    % TODO: remove any outliers in the inpout data that will mess with the fit
    XnormClean = hampel(X,10);

%     XnormClean = X;
end