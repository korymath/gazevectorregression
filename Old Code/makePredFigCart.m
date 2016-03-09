function fig = makePredFigCart(V,pP,pPF)

fig = figure;
ax(1) = subplot(3,1,1);
plot(V(:,1),'LineWidth',2);
hold on;
plot(pP(:,1),'LineWidth',2); 
plot(pPF(:,1),'LineWidth',2); 
title('X-position Prediction Accuracy','FontSize',24);
ylabel('Position (mm)','FontSize', 24);
h_legend = legend('Actual','Predicted','FiltPred');
set(h_legend,'FontSize',18);

ax(2) = subplot(3,1,2);
plot(V(:,2),'LineWidth',2);
hold on;
plot(pP(:,2),'LineWidth',2); 
plot(pPF(:,2),'LineWidth',2); 
title('Y-position Prediction Accuracy','FontSize',24);
ylabel('Position (mm)','FontSize', 24);
h_legend = legend('Actual','Predicted','FiltPred');
set(h_legend,'FontSize',18);

ax(3) = subplot(3,1,3);
plot(V(:,3),'LineWidth',2);
hold on;
plot(pP(:,3),'LineWidth',2); 
plot(pPF(:,3),'LineWidth',2); 
title('Z-position Prediction Accuracy','FontSize',24);
linkaxes(ax,'x');
h_legend = legend('Actual','Predicted','FiltPred');
set(h_legend,'FontSize',18);
ylabel('Position (mm)','FontSize', 24);
xlabel('Sample Number', 'FontSize', 24);

% figure; 
% plot3(V(:,1),V(:,2),V(:,3));
% hold on;
% plot3(pP(:,1),pP(:,2),pP(:,3));

end