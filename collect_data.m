function [eyeData,markerData,transformMatrix,offset,trueMarker,info] = collect_data(strCell,subId,condFlag)

tic

allDLAB = [];
allVICON = [];
allDetails = [];

for strNum = 1:length(strCell)
    
    dataIn = load([pwd '/data/' strCell{strNum}]);
    dataHeaders = dataIn.cHeader;
    
    try
        iDLAB = [find(strcmp(dataHeaders,'E:LeftPupil:X')),...
            find(strcmp(dataHeaders,'E:LeftPupil:Y')),...
            find(strcmp(dataHeaders,'E:RightPupil:X')),...
            find(strcmp(dataHeaders,'E:RightPupil:Y'))];
    catch ME
        print(ME);
    end
    
    newDLAB = dataIn.cData(:,iDLAB);
    
    % append next data
    allDLAB = [allDLAB;newDLAB];
    
    try
        iVICON = [find(strcmp(dataHeaders,'M:Wand:Tip:X')),...
            find(strcmp(dataHeaders,['M:' subId ':RFHD:X'])),...
            find(strcmp(dataHeaders,['M:' subId ':RBHD:X'])),...
            find(strcmp(dataHeaders,['M:' subId ':LFHD:X'])),...
            find(strcmp(dataHeaders,['M:' subId ':LBHD:X']))];
    catch ME
        print(ME);
    end
    
    if length(iVICON) < 5
        try
            iVICON = [find(strcmp(dataHeaders,'M:Wand:Tip:X')),...
                find(strcmp(dataHeaders,['M:Head:RFHD:X'])),...
                find(strcmp(dataHeaders,['M:Head:RBHD:X'])),...
                find(strcmp(dataHeaders,['M:Head:LFHD:X'])),...
                find(strcmp(dataHeaders,['M:Head:LBHD:X']))];
        catch ME
            print(ME);
        end
    end
    
    if length(iVICON) < 5
        try
            iVICON = [find(strcmp(dataHeaders,'M:Wand:Tip:X')),...
                find(strcmp(dataHeaders,['M:Head:RFRNT:X'])),...
                find(strcmp(dataHeaders,['M:Head:RBCK:X'])),...
                find(strcmp(dataHeaders,['M:Head:LFRNT:X'])),...
                find(strcmp(dataHeaders,['M:Head:LBCK:X']))];
        catch ME
            print(ME);
        end
    end
    
    if length(iVICON) < 5
        try
            iVICON = [find(strcmp(dataHeaders,'M:Wand:Tip:X')),...
                find(strcmp(dataHeaders,['M:' subId '_2:RFHD:X'])),...
                find(strcmp(dataHeaders,['M:' subId '_2:RBHD:X'])),...
                find(strcmp(dataHeaders,['M:' subId '_2:LFHD:X'])),...
                find(strcmp(dataHeaders,['M:' subId '_2:LBHD:X']))];
        catch ME
            print(ME);
        end
    end

    if length(iVICON) < 5
        try
            iVICON = [find(strcmp(dataHeaders,'M:Wand:Tip:X')),...
                find(strcmp(dataHeaders,['M:' subId '_3:RFHD:X'])),...
                find(strcmp(dataHeaders,['M:' subId '_3:RBHD:X'])),...
                find(strcmp(dataHeaders,['M:' subId '_3:LFHD:X'])),...
                find(strcmp(dataHeaders,['M:' subId '_3:LBHD:X']))];
        catch ME
            print(ME);
        end
    end
    
    inputCols = [];
    for i=1:length(iVICON)
        % order of the input columns needs to be strictly defined
        % RFHD RBHD LFHD LBHD for the correct transformation function to work
        inputCols = [inputCols iVICON(i) iVICON(i)+1 iVICON(i)+2];
    end
    
    newVICON = dataIn.cData(:,inputCols);
    
    allVICON = [allVICON; newVICON];
    
    % Get the calibration information
    try
        iDetails = [find(strcmp(dataHeaders,'CI:CalType')),...
            find(strcmp(dataHeaders,'CI:HeadMoveType')),...
            find(strcmp(dataHeaders,'CI:CalNum'))];
    catch ME
        print(ME);
    end
    
    newDetails = dataIn.cData(:,iDetails);
    
    % append next data
    allDetails = [allDetails;newDetails];
    
    toc
    
end

%% Prepare for the output

% True Points of the Marker Tip in Head Space
[markerData,transformMatrix,offset] = transform_vicon_to_head(allVICON,iVICON);

% True Points of the Marker Tip in VICON Space
trueMarker = allVICON(:,1:3);

eyeData = allDLAB;

% Get the calibration information indicies
info = get_cal_info(allDetails);


%% Use the conditions to return only the data for this experiment
%   Use the condition flag to slice the data based on the condition given
% conditions can be set by using the following flags:
% 'all': all data
% 'sweep': sweep data
% 'grid': grid data
% 'fixed': head fixed data
% 'free': head free data
% 'task': task data
eye_slice = 1:4;

switch condFlag
    case 'all'
        slice = 1:size(dataIn.cData,1);
    case 'sweep'
        slice = info.sweepIdx;
    case 'grid'
        slice = info.gridIdx;
    case 'free'
        slice = info.headfreeIdx;
    case 'fixed'
        slice = info.headfixedIdx;
    case 'task'
        slice = info.taskIdx;
    case 'free_oneeye'
        slice = info.headfreeIdx;
        eye_slice = 1:2;
    case 'task_oneeye'
        slice = info.taskIdx;
        eye_slice = 1:2;
    otherwise
        slice = 1:size(dataIn.cData,1);
end

eyeData = eyeData(slice,eye_slice);
markerData = markerData(slice,:);
transformMatrix = transformMatrix(:,:,slice);
offset = offset(:,slice);
trueMarker = trueMarker(slice,:);

end