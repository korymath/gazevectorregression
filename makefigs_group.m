function [ output_args ] = makefigs_group( str, errDistVec, errDistLen, errMean )
%MAKEFIGS_GROUP Make the group figures
% Build some nice figures from the experiment
f = figure('visible','off');
boxplot(errDistVec,errDistLen,'Notch','on');

filename = [pwd '/data/proc/output_' str '_BOX.jpg'];
saveas(f,filename);

f = figure('visible','off');
imagesc(errMean); colorbar; colormap(jet);

filename = [pwd '/data/proc/output_' str '_HEAT.jpg'];
saveas(f,filename);

% TODO: add time series error plot as per Kory's earlier examples, so we
% can see where things go wrong / right on a step by step basis.

end

