X = 1:length(predPos(:,1));
Y = predPos(:,1);

[YY,I,Y0,LB,UB] = hampel(X,Y);

      plot(X, Y, 'b.'); hold on;      % Original Data
      plot(X, YY, 'r');               % Hampel Filtered Data
      plot(X, Y0, 'b--');             % Nominal Data
      plot(X, LB, 'r--');             % Lower Bounds on Hampel Filter
      plot(X, UB, 'r--');             % Upper Bounds on Hampel Filter
      plot(X(I), Y(I), 'ks');         % Identified Outliers