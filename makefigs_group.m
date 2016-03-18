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

end

