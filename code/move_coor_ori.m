function [ coor ] = move_coor_ori(points)
% points: 1st column: center, end column: neuron number, middle: coor
[~,dim] = size(points);
coor = zeros(2,dim);
coor(:,1) = [0;0];
coor(1,end) = points(1,end);
coor(:,2:end-1) = points(:,2:end-1) - repmat(points(:,1),1,dim-1);
end