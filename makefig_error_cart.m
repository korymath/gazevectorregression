function makefig_error_cart(er,er_mean)

figure;
plot(er,'LineWidth',2);
hold on; plot(er_mean*ones(1,length(er)),'r-','LineWidth',4);
title('Error vs. Sample Number', 'FontSize', 24);
ylabel('Distance Error (cm)', 'FontSize', 24);
xlabel('Sample Number', 'FontSize', 24);

return