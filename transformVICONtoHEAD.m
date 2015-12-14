function [TP,transformMatrix,offset] = transformVICONtoHEAD(resampVICON,iV)
% This function converts the motion capture centric marker data to the
% coordinate system of the head. It also outputs a transformation matrix
% and an offset so that we can do the revse transformation later in the
% processing

TP = zeros(length(resampVICON),3);

transformMatrix = zeros(3,3,size(resampVICON,1));
offset = zeros(3,size(resampVICON,1));

% Get the order that the matrix is in
[~,sortOrder]=sort(iV);

% Get the starting index in the resampVICON array for 
% the Right Forehead, Right Temple and Left Forehead

% This is data that includes the marker tip
if (length(sortOrder) == 5)
    rf = ((sortOrder(2)-1)*3)+1; % 4; % 2nd element = 2 in sortOrder
    rt = ((sortOrder(3)-1)*3)+1; % 10; % 3rd element = 4 in sortOrder
    lf = ((sortOrder(4)-1)*3)+1; % 7; % 4th element = 3 in sortOrder
else
    % this is data that does not have the marker as part of the data
    % thus the right front is the first element of interest
    rf = ((sortOrder(1)-1)*3)+1; 
    rt = ((sortOrder(2)-1)*3)+1; 
    lf = ((sortOrder(3)-1)*3)+1;
end

% Resort the data according to that sort order
sortedData = [resampVICON(:,rf:rf+2) resampVICON(:,rt:rt+2) resampVICON(:,lf:lf+2)];

% Need to resort the data if it is out of order

for i=1:size(sortedData,1);    
    % Collect the head points in a plane 
    A = sortedData(i,1:3); % Right Forehead
    B = sortedData(i,4:6); % Right Temple
    C = sortedData(i,7:9); % Left Forehead

    % Compute the three new axes based on the head points
    v1 = B-A; 
    v1 = v1/norm(v1);
    v3 = cross(v1,C-A); 
    v3 = v3/norm(v3);
    v2 = cross(v3,v1); % v2 is already a unit vector
    
    % Axis is orthonormal as [v1;v2;v3]*[v1;v2;v3]' is identity
    
    % Transform each point to head coordinate system
    P = resampVICON(i,1:3);
    TP(i,:) = [dot(P-A,v1),dot(P-A,v2),dot(P-A,v3)];
    
    transformMatrix(:,:,i) = [v1;v2;v3]';
%     TP(i,:) = (P-A)*transformMatrix(:,:,i);
    offset(:,i) = A;
end

end