function [ points_1_removed, points_2_removed ] = remove_outlier(points_1,points_2,epsilon_1,epsilon_2)
dim_1 = length(points_1(1,:));
dim_2 = length(points_2(1,:));
med_1 = [median(points_1(1,:));median(points_1(2,:))];
med_2 = [median(points_2(1,:));median(points_2(2,:))];
dist_1 = zeros(dim_1,1);
dist_2 = zeros(dim_2,1);
for i = 1:dim_1
    dist_1(i) = norm(points_1(:,i)-med_1);
end
for i = 1:dim_2
    dist_2(i) = norm(points_2(:,i)-med_2);
end
[~,index_1] = sort(dist_1,'ascend');
[~,index_2] = sort(dist_2,'ascend');
% num_remain_1 = floor((1-epsilon_1)*dim_1);
% num_remain_2 = floor((1-epsilon_2)*dim_2);
num_remain_1 = floor(epsilon_1*dim_1);
num_remain_2 = floor(epsilon_2*dim_2);
points_1_removed = points_1(:,index_1(1:num_remain_1));
points_2_removed = points_2(:,index_2(1:num_remain_2));
end