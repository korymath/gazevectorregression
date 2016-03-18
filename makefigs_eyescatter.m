%function [ output_args ] = makefigs_eyescatter( str, eyeData , details )
%MAKEFIGS_EYESCATTER Make pupil scatter plots
% Build some nice figures from the experiment

k = dir([pwd '/data/*.mat']);
files = {k.name}';

% TODO: add coverage (barplot) and density (boxpot) measures for
% all,sweep,grid with fixed,free,task

for i=1:length(files)
    [eyeData,markerData,tM,offset,trueMarker,details] = collect_data({files{i}},files{i}(1:3),'all');
    
    f = figure('visible','off');
    ax1 = subplot(2,2,1);
    scatter(ax1,eyeData(details.headfreeIdx,1),eyeData(details.headfreeIdx,2),2,'red');
    xlim([50 300])
    ylim([50 250])
    xlabel('Pupil X')
    ylabel('Pupil Y')
    title('HeadFree')
    
    ax2 = subplot(2,2,2);
    scatter(ax2,eyeData(details.headfixedIdx,1),eyeData(details.headfixedIdx,2),2,'blue','s');
    xlim([50 300])
    ylim([50 250])
    xlabel('Pupil X')
    ylabel('Pupil Y')
    title('HeadFixed')
    
    ax3 = subplot(2,2,3);
    scatter(ax3,eyeData(details.taskIdx,1),eyeData(details.taskIdx,2),2,[0.8,0.8,0],'d');
    xlim([50 300])
    ylim([50 250])
    xlabel('Pupil X')
    ylabel('Pupil Y')  
    title('Task')
    
    ax4 = subplot(2,2,4);
    hold on;
    scatter(ax4,eyeData(details.headfixedIdx,1),eyeData(details.headfixedIdx,2),2,'blue','s');
    scatter(ax4,eyeData(details.headfreeIdx,1),eyeData(details.headfreeIdx,2),2,'red');
    scatter(ax4,eyeData(details.taskIdx,1),eyeData(details.taskIdx,2),2,[0.8,0.8,0],'d');    
    xlim([50 300])
    ylim([50 250])
    xlabel('Pupil X')
    ylabel('Pupil Y')    
    title('Composite')

    filename = [pwd '/data/proc/output_' files{i} '_EYE.png'];
    saveas(f,filename);

end

% f = figure('visible','off');
% for i=1:length(files)
%     [eyeData,markerData,tM,offset,trueMarker,details] = collect_data({files{i}},files{i}(1:3),'all');
% 
%     %f = figure('visible','off');
%     ax1 = subplot(2,2,1);
%     hold on;
%     scatter(ax1,eyeData(details.headfreeIdx,1),eyeData(details.headfreeIdx,2),2,'red');
%     xlim([50 300])
%     ylim([50 250])
%     xlabel('Pupil X')
%     ylabel('Pupil Y')
%     title('HeadFree')
%     
%     ax2 = subplot(2,2,2);
%     hold on;
%     scatter(ax2,eyeData(details.headfixedIdx,1),eyeData(details.headfixedIdx,2),2,'blue','s');
%     xlim([50 300])
%     ylim([50 250])
%     xlabel('Pupil X')
%     ylabel('Pupil Y')
%     title('HeadFixed')
%     
%     ax3 = subplot(2,2,3);
%     hold on;
%     scatter(ax3,eyeData(details.taskIdx,1),eyeData(details.taskIdx,2),2,[0.8,0.8,0],'d');
%     xlim([50 300])
%     ylim([50 250])
%     xlabel('Pupil X')
%     ylabel('Pupil Y')  
%     title('Task')
%     
%     ax4 = subplot(2,2,4);
%     hold on;
%     scatter(ax4,eyeData(details.headfixedIdx,1),eyeData(details.headfixedIdx,2),2,'blue','s');
%     scatter(ax4,eyeData(details.headfreeIdx,1),eyeData(details.headfreeIdx,2),2,'red');
%     scatter(ax4,eyeData(details.taskIdx,1),eyeData(details.taskIdx,2),2,[0.8,0.8,0],'d');    
%     xlim([50 300])
%     ylim([50 250])
%     xlabel('Pupil X')
%     ylabel('Pupil Y')    
%     title('Composite')
% 
% end

% filename = [pwd '/data/proc/output_composite_EYE.png'];
% saveas(f,filename);
