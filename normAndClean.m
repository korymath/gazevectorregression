function XnormClean = normAndClean(X)
    % normalize and standardize the input features
    [Xnorm, ~, ~] = featureNormalize(X);

    % TODO: remove any outliers in the inpout data that will mess with the fit
    XnormClean = hampel(Xnorm(:,:),10);
end