function [cluster] = global_cluster(group_1,group_2)
len_1 = length(group_1);
len_2 = length(group_2);
cluster = {};
cluster{1} = zeros(len_1+len_2,2);
for i = 1:len_1
    cluster{1}(i,:) = [group_1{i}(1,end),1];
end
for i = 1:len_2
    cluster{1}(i+len_1,:) = [group_2{i}(1,end),2];
end