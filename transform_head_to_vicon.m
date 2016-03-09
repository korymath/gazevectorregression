function TP = transform_head_to_vicon(markerData,transformMatrix,offset)
% This function transforms the data from the headspace to the coordinate
% system defined by the motion capture system based on the inverse of the
% transformation matrix and the offset to the right eye

TP = zeros(length(markerData),3);

for i=1:size(TP,1);    
    TP(i,:) = (markerData(i,:)/transformMatrix(:,:,i))+offset(:,i)';
end

end