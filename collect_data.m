function [eyeData,markerData,transformMatrix,offset,trueMarker] = collect_data(strCell,subId)

tic

allDLAB = [];

for strNum = 1:length(strCell)
    
    dataIn = load([pwd '/data/' strCell{strNum} '.mat']);
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
    
end

%%

allVICON = [];

for strNum = 1:length(strCell)
    
    
    try
        iVICON = [find(strcmp(dataHeaders,'M:Wand:Tip:X')),...
            find(strcmp(dataHeaders,['M:' subId ':RFHD:X'])),...
            find(strcmp(dataHeaders,['M:' subId ':RBHD:X'])),...
            find(strcmp(dataHeaders,['M:' subId ':LFHD:X'])),...
            find(strcmp(dataHeaders,['M:' subId ':LBHD:X']))];
    catch ME
        print(ME);
    end
    
    inputCols = [];
    for i=1:length(iVICON)
        % order of the input columns needs to be strictly defined
        % RFHD RBHD LFHD LBHD for the correct transformation function to work
        inputCols = [inputCols iVICON(i) iVICON(i)+1 iVICON(i)+2];
    end
    
    newVICON = dataIn.cData(:,inputCols);
    
    allVICON = [allVICON; newVICON];
    
    toc
    
end

% True Points of the Marker Tip in Head Space
[markerData,transformMatrix,offset] = transform_vicon_to_head(allVICON,iVICON);

% True Points of the Marker Tip in VICON Space
trueMarker = allVICON(:,1:3);

eyeData = allDLAB;

end