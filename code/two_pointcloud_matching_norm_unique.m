%using norm of the difference between two matrices
function [unique_matching_result,cost] = two_pointcloud_matching_norm_unique(points_1,points_2,dtheta,num_R)
matching_result = match_norm(points_1,points_2,dtheta,num_R);
unique_values_2 = unique(matching_result(:,2));
len_unique = length(unique_values_2);
index_unique = [];
for i = 1:len_unique
    index = find(matching_result(:,2)==unique_values_2(i));
    [~,min_ind] = min(norm(points_1(:,matching_result(index,1))-points_2(:,matching_result(index,2))));
    index_unique = [index_unique;index(min_ind)];
end
unique_matching_result = matching_result(index_unique,:);

%cost calculation
cost = 0;
n_old = length(matching_result(:,1));
binc1 = binc(points_1,dtheta,num_R);
binc2 = binc(points_2,dtheta,num_R);
for i = 1:n_old
    cost = cost + norm(binc1(matching_result(i,1),:)-binc2(matching_result(i,2),:));
end
cost = cost/n_old;
end