function [eyeData,markerData,transformMatrix,offset,trueMarker] = collectData(str,ptStr)
tic
headersDLAB = importDlabA83header([pwd '/raw/Dlab_' str '.csv']);

try
    iVDLAB = [find(strcmp(headersDLAB,'Dikablis Professional_Eye Data_Processed Data_Left Eye_Pupil X')),...
        find(strcmp(headersDLAB,'Dikablis Professional_Eye Data_Processed Data_Left Eye_Pupil Y')),...
        find(strcmp(headersDLAB,'Dikablis Professional_Eye Data_Processed Data_Right Eye_Pupil X')),...
        find(strcmp(headersDLAB,'Dikablis Professional_Eye Data_Processed Data_Right Eye_Pupil Y'))];
catch ME
    ME
end

format=[];
for I=1:length(headersDLAB)
    if any(I==iVDLAB)
        format=[format '%f'];
    else
        if (I==1 || I == 2)
            format=[format '%*s'];
        else
            format=[format '%*f'];
        end
    end
end
format = [format '%[^\n\r]'];

dataDLAB = importDlabA83([pwd '/raw/Dlab_' str '.csv'],format);

interpDLAB = zeros(size(dataDLAB,1),4);

for i = 1:4
    X = dataDLAB(:,i);
    X(X==0) = NaN;
    X(isnan(X)) = interp1(find(~isnan(X)), X(~isnan(X)), find(isnan(X)),'pchip');
    interpDLAB(:,i) = X;
end

clear X i;
toc

%%

C = importViconA83header([pwd '/raw/Vicon_' str '.csv']);

lens = cellfun('length',C);
max_lens = max(lens);
C1 = cell(max_lens,numel(C));
C1(bsxfun(@le,[1:max_lens]',lens)) = [C{:}]; %//'

headersVICON = C1;

iV = [find(strcmp(headersVICON,'Wand:Tip')),...
    find(strcmp(headersVICON,[ptStr,':RFHD'])),...
    find(strcmp(headersVICON,[ptStr,':RBHD'])),...
    find(strcmp(headersVICON,[ptStr,':LFHD'])),...
    find(strcmp(headersVICON,[ptStr,':LBHD']))];

inputCols = [];
for i=1:length(iV)
    inputCols = [inputCols iV(i) iV(i)+1 iV(i)+2];
end

format=[];
for I=1:length(headersVICON)
    if any(I==inputCols)
        format=[format '%f'];
    else
        format=[format '%*f'];
    end
end
format = [format '%[^\n\r]'];

dataVICON = importViconA83([pwd '/raw/Vicon_' str '.csv'],format);

% resampVICON = zeros(size(interpDLAB,1),12);

% for i = 1:size(dataVICON,2)
%     resampVICON(:,i) = resample(dataVICON(:,i),size(eyeData,1),length(dataVICON(:,1)));
% end

for i = 1:size(dataVICON,2)
    X = dataVICON(:,i);
    X(X==0) = NaN;
    X(isnan(X)) = interp1(find(~isnan(X)), X(~isnan(X)), find(isnan(X)),'pchip');
    dataVICON(:,i) = X;
end

clear i;

toc

% saveAndVisualize;

% True Points of the Marker Tip in Head Space
[markerData,transformMatrix,offset] = transformVICONtoHEAD(dataVICON);

% True Points of the Marker Tip in VICON Space
trueMarker = dataVICON(:,1:3);

% Downsample the eyedata to the length of the VICON dataa
eyeData = resample(interpDLAB,length(dataVICON),length(dataDLAB));

toc

% indexVec should be the index of the following in order:
% wandX, rForehead, rTemple, lForehead, lTemple

save([pwd '/TestingA83/collectData/' str '.mat']);

end