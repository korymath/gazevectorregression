function [predPos,predPosFilt,mdl] = build_models(eyeData,markerData)

predPos = zeros(length(eyeData),3);
predPosFilt = zeros(length(eyeData),3);

mdl = cell(3,1);

for i=1:3
    [predPos(:,i),mdl{i}] = build_single_model(eyeData,markerData(:,i));
    predPosFilt(:,i) = hampel(predPos(:,i),150);
end

end