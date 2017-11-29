function [distances_matrix] = distances(coor_1,coor_2)
len_1 = length(coor_1);
len_2 = length(coor_2);
distances_matrix = zeros(len_1,len_2);
for i = 1:len_1
    for j = 1:len_2
        distances_matrix(i,j) = norm(coor_1{i}(:,1)-coor_2{j}(:,1));
    end    
end
end