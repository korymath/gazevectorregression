function [predPos,mdl] = build_single_model(X,Y)

% build the model
mdl = fitlm(X,Y,'quadratic','RobustOpts','on');

% predict the positions using the given model
predPos = predict(mdl,X);  

end





