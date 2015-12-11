function [predPos,predPosFilt,mdl] = calcGazeCart(eyeData,markerData)

predPos = zeros(length(eyeData),3);
predPosFilt = zeros(length(eyeData),3);

mdl = cell(3,1);

for i=1:3
    [predPos(:,i),mdl{i}] = calcPos(eyeData,markerData(:,i));
    predPosFilt(:,i) = hampel(predPos(:,i),150);
    i
end

makePredFigCart(markerData,predPos,predPosFilt);

% testModelCartNew

end