function [eyeData,markerData,transformMatrix,offset,trueMarker] = collectDataA12(strCell)

tic

allDLAB = [];

for strNum = 1:length(strCell)
    
    headersDLAB = importDlabA16header([pwd '/raw/D_' strCell{strNum} '.csv']);

    try
        iVDLAB = [find(strcmp(headersDLAB,'LeftPupil_X')),...
            find(strcmp(headersDLAB,'LeftPupil_Y')),...
            find(strcmp(headersDLAB,'RightPupil_X')),...
            find(strcmp(headersDLAB,'RightPupil_Y'))];
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

    dataDLAB = importDlabA16([pwd '/raw/D_' strCell{strNum} '.csv'],format);

    interpDLAB = dataDLAB; % zeros(size(dataDLAB,1),4);

%     for i = 1:4
%         X = dataDLAB(:,i);
%         X(X==0) = NaN;
%         X(isnan(X)) = interp1(find(~isnan(X)), X(~isnan(X)), find(isnan(X)),'pchip');
%         interpDLAB(:,i) = X;
%     end
%     clear X i;
%     toc
    
    % append next data to the bottom
    allDLAB = [allDLAB;interpDLAB];

end

%%

allVICON = [];

for strNum = 1:length(strCell)

    C = importViconA83header([pwd '/raw/V_' strCell{strNum} '.csv']);

    lens = cellfun('length',C);
    max_lens = max(lens);
    C1 = cell(max_lens,numel(C));
    C1(bsxfun(@le,[1:max_lens]',lens)) = [C{:}]; %//'

    headersVICON = C1;

    iV = [find(strcmp(headersVICON,'Wand:Tip')),...
        find(~cellfun(@isempty,regexp(headersVICON,'Head:RFHD'))),...
        find(~cellfun(@isempty,regexp(headersVICON,'Head:RBHD'))),...
        find(~cellfun(@isempty,regexp(headersVICON,'Head:LFHD'))),...
        find(~cellfun(@isempty,regexp(headersVICON,'Head:LBHD')))];

    inputCols = [];
    for i=1:length(iV)
        % order of the input columns needs to be strictly defined
        % RFHD RBHD LFHD LBHD for the correct transformation function to work
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

    dataVICON = importViconA83([pwd '/raw/V_' strCell{strNum} '.csv'],format);

    % resampVICON = zeros(size(interpDLAB,1),12);

    % for i = 1:size(dataVICON,2)
    %     resampVICON(:,i) = resample(dataVICON(:,i),size(eyeData,1),length(dataVICON(:,1)));
    % end

%     for i = 1:size(dataVICON,2)
%         X = dataVICON(:,i);
%         X(X==0) = NaN;
%         X(isnan(X)) = interp1(find(~isnan(X)), X(~isnan(X)), find(isnan(X)),'pchip');
%         dataVICON(:,i) = X;
%     end

    clear i;
    
    allVICON = [allVICON; dataVICON];
    
    toc

end

% saveAndVisualize;

% True Points of the Marker Tip in Head Space
[markerData,transformMatrix,offset] = transformVICONtoHEAD(allVICON,iV);

% True Points of the Marker Tip in VICON Space
trueMarker = allVICON(:,1:3);

% Downsample the eyedata to the length of the VICON dataa
eyeData = resample(allDLAB,length(allVICON),length(allDLAB));

% indexVec should be the index of the following in order:
% wandX, rForehead, rTemple, lForehead, lTemple

% save([pwd '/TestingA83/collectData/' strCell '.mat']);

end