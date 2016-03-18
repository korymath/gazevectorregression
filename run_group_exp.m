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

