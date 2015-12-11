function [TP,transformMatrix,offset] = transformVICONtoHEAD(resampVICON)
% This function converts the motion capture centric marker data to the
% coordinate system of the head. It also outputs a transformation matrix
% and an offset so that we can do the revse transformation later in the
% processing

TP = zeros(length(resampVICON),3);

transformMatrix = zeros(3,3,size(resampVICON,1));
offset = zeros(3,size(resampVICON,1));

for i=1:size(resampVICON,1);    
    % Collect the head points in a plane 
    A = resampVICON(i,4:6); % Right Forehead
    B = resampVICON(i,7:9); % Right Temple
    C = resampVICON(i,10:12); % Left Forehead

    % Compute the three new axes based on the head points
    v1 = B-A; 
    v1 = v1/norm(v1);
    v3 = cross(v1,C-A); v3 = v3/norm(v3);
    v2 = cross(v3,v1); % v2 is already a unit vector
    
    % Axis is orthonormal as [v1;v2;v3]*[v1;v2;v3]' is identity
    
    % Transform each point to head coordinate system
    P = resampVICON(i,1:3);
%     TP(i,:) = [dot(P-A,v1),dot(P-A,v2),dot(P-A,v3)];
    
    transformMatrix(:,:,i) = [v1;v2;v3]';
    TP(i,:) = (P-A)*transformMatrix(:,:,i);
    offset(:,i) = A;
end

end