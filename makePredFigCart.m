function fig = makePredFigCart(V,pPF)

fig = figure;
ax(1) = subplot(3,1,1);
plot(V(:,1),'LineWidth',2);
hold on; 
plot(pPF(:,1),'LineWidth',2); 
title('X-position Prediction Accuracy','FontSize',24);
ylabel('Position (mm)','FontSize', 24);
h_legend = legend('Actual','FiltPredicted');
set(h_legend,'FontSize',18);

ax(2) = subplot(3,1,2);
plot(V(:,2),'LineWidth',2);
hold on;
plot(pPF(:,2),'LineWidth',2); 
title('Y-position Prediction Accuracy','FontSize',24);
ylabel('Position (mm)','FontSize', 24);
h_legend = legend('Actual','FiltPredicted');
set(h_legend,'FontSize',18);

ax(3) = subplot(3,1,3);
plot(V(:,3),'LineWidth',2);
hold on;
plot(pPF(:,3),'LineWidth',2); 
title('Z-position Prediction Accuracy','FontSize',24);
linkaxes(ax,'x');
h_legend = legend('Actual','FiltPredicted');
set(h_legend,'FontSize',18);
ylabel('Position (mm)','FontSize', 24);
xlabel('Sample Number', 'FontSize', 24);

end