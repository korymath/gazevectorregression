function [predPos,mdl] = build_single_model(X,Y)

% build the model
mdl = fitlm(X,Y,'quadratic','RobustOpts','on');

csvwrite('X.dat',X)
csvwrite('Y.dat',Y)

% predict the positions using the given model
predPos = predict(mdl,X);  

end





