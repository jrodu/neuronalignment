function [Adj_matrix] = construct_adjacency(coor_1,coor_2,thres_center)
% Adj_matrix: row 1~len_1 corresponds group_1, len_1+1~len_1+len_2
% corresponds group_2
distances_matrix = distances(coor_1,coor_2);
len_1 = length(coor_1);
len_2 = length(coor_2);
Adj_matrix = zeros(len_1+len_2,len_1+len_2);
% left bottom
for i = 1:len_2
    for j = 1:len_1
        if distances_matrix(j,i) <= thres_center
            Adj_matrix(i+len_1,j) = 1;
        end
    end
end
% right top
for i = 1:len_1
    for j = 1:len_2
        if distances_matrix(i,j) <= thres_center
            Adj_matrix(i,j+len_1) = 1;
        end
    end
end
end