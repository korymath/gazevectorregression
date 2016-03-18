k = dir([pwd '/data/proc/output*.mat']);
files = {k.name}';

sweepNum = 1;
gridNum = 1;

for i=1:length(files)
    data{i} = load([pwd '/data/proc/' files{i}] );
    if data{i}.calType == 1
        % sweep
        dataSweep{sweepNum} = data{i};
        sweepNum = sweepNum + 1;
    elseif data{i}.calType == 2
        % grid
        dataGrid{gridNum} = data{i};
        gridNum = gridNum + 1;
    end
    disp(num2str(i));
    
    errMeanAll(:,:,i) = data{i}.errMean;
    errStdAll(:,:,i) = data{i}.errStd;
end

% Process all the sweep files
for i=1:length(dataSweep)
    errMeanSweep(:,:,i) = dataSweep{i}.errMean;
    errStdSweep(:,:,i) = dataSweep{i}.errStd;
end

% Process all the grid files
for i=1:length(dataGrid)
    errMeanGrid(:,:,i) = dataGrid{i}.errMean;
    errStdGrid(:,:,i) = dataGrid{i}.errStd;
end

errMeanAll(errMeanAll == 0) = NaN;
errMeanSweep(errMeanSweep == 0) = NaN;
errMeanGrid(errMeanGrid == 0) = NaN;

errMeanAllMean = nanmean(errMeanAll,3);
errMeanSweepMean = nanmean(errMeanSweep,3);
errMeanGridMean = nanmean(errMeanGrid,3);

errMeanAllStd = nanstd(errMeanAll,0,3)/sqrt(length(errMeanAll));
errMeanSweepStd = nanstd(errMeanSweep,0,3)/sqrt(length(errMeanSweep));
errMeanGridStd = nanstd(errMeanGrid,0,3)/sqrt(length(errMeanGrid));

<<<<<<< HEAD
%% 
f = figure('Position', [100, 100, 1200, 600]); 
lbl = {'All','Free','Fixed','Task'};
% subplot(131); imagesc(errMeanAllMean, [0 20]); colorbar; colormap(jet); title('Mean Error All (cm)')
% set(gca,'xtick',[1 2 3 4]); set(gca,'xticklabel',lbl); set(gca,'ytick',[1 2 3 4]); set(gca,'yticklabel',lbl);
subplot(121); imagesc(errMeanSweepMean, [0 20]); colorbar; colormap(jet); title('Mean Error Sweep (cm)')
set(gca,'xtick',[1 2 3 4]); set(gca,'xticklabel',lbl); set(gca,'ytick',[1 2 3 4]); set(gca,'yticklabel',lbl);
subplot(122); imagesc(errMeanGridMean, [0 20]); colorbar; colormap(jet); title('Mean Error Grid (cm)')
set(gca,'xtick',[1 2 3 4]); set(gca,'xticklabel',lbl); set(gca,'ytick',[1 2 3 4]); set(gca,'yticklabel',lbl);

filename = [pwd '/data/proc/group/output_group_HEAT.jpg'];
saveas(f,filename);

%% 

% pull out only the free vectors
t_1 = squeeze(errMeanSweep(2,4,:));
t_2 = squeeze(errMeanGrid(2,4,:));

% pull out only the fixed vectors
t_3 = squeeze(errMeanSweep(3,4,:));
t_4 = squeeze(errMeanGrid(3,4,:));

f2 = figure('Position', [100, 100, 1200, 1200]); 
errVec = [t_1; t_2; t_3; t_4];
grp = [0*ones(1,length(t_1)), 1*ones(1,length(t_2)), 2*ones(1,length(t_3)), ...
    3*ones(1,length(t_4))];
h= boxplot(errVec,grp,'Notch','on');
set(h(7,:),'Visible','off') % hide outliers
ylim([0 100])
lbl = {'Sweep Free/Task', 'Grid Free/Task','Sweep Fixed/Task', 'Grid Fixed/Task'};
set(gca,'xtick',[1 2 3 4]); set(gca,'xticklabel',lbl);

filename = [pwd '/data/proc/group/output_group_BOX.jpg'];
saveas(f2,filename);
=======
f=figure; imagesc(errMeanAllMean, [0 50]); colorbar; colormap(hot);
filename = [pwd '/data/proc/output_heatmap_comparison_all.png'];
title('All Mean Error')
saveas(f,filename);
f=figure; imagesc(errMeanSweepMean, [0 50]); colorbar; colormap(hot);
filename = [pwd '/data/proc/output_heatmap_comparison_sweep.png'];
title('Sweep Mean Error')
saveas(f,filename);
f=figure; imagesc(errMeanGridMean, [0 50]); colorbar; colormap(hot);
filename = [pwd '/data/proc/output_heatmap_comparison_grid.png'];
title('Grid Mean Error')
saveas(f,filename);

%StdErr
f=figure; imagesc(errMeanAllStd, [0 10]); colorbar; colormap(parula);
filename = [pwd '/data/proc/output_heatmap_comparison_stderr_all.png'];
title('All StdErr')
saveas(f,filename);
f=figure; imagesc(errMeanSweepStd, [0 10]); colorbar; colormap(parula);
filename = [pwd '/data/proc/output_heatmap_comparison_stderr_sweep.png'];
title('Sweep StdErr')
saveas(f,filename);
f=figure; imagesc(errMeanGridStd, [0 10]); colorbar; colormap(parula);
filename = [pwd '/data/proc/output_heatmap_comparison_stderr_grid.png'];
title('Grid StdErr')
saveas(f,filename);

% Create colormap that is green for negative, red for positive,
% and a chunk inthe middle that is black.
greenColorMap = [zeros(1, 132), linspace(0, 1, 124)];
redColorMap = [linspace(1, 0, 124), zeros(1, 132)];
colorMap = [redColorMap; greenColorMap; zeros(1, 256)]';
%Plot Diff
errMeanSweepMean(2,3)=0;
errMeanSweepMean(3,2)=0;
errMeanGridMean(2,3)=0;
errMeanGridMean(3,2)=0;
f=figure; imagesc(errMeanGridMean-errMeanSweepMean, [-10 10]); colorbar; colormap(colorMap);
title('Comparative error for Grid minus Sweep')
filename = [pwd '/data/proc/output_heatmap_comparison_sweepgriddiff.png'];
saveas(f,filename);
>>>>>>> origin/master

