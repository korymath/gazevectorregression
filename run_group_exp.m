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

errMeanAllMean = nanmean(errMeanAll,4);
errMeanSweepMean = nanmean(errMeanSweep,4);
errMeanGridMean = nanmean(errMeanGrid,4);

errMeanAllStd = nanstd(errMeanAll,4);
errMeanSweepStd = nanstd(errMeanSweep,4);
errMeanGridStd = nanstd(errMeanGrid,4);

