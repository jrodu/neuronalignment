function [clusters,bins] = adjacency_cluster(adjacency_matrix,coor_1,coor_2)
len_1 = length(coor_1);
len_2 = length(coor_2);
group_1 = zeros(len_1,1);
group_2 = zeros(len_2,1);
for i = 1:len_1
    group_1(i) = coor_1{i}(1,end);
end
for i = 1:len_2
    group_2(i) = coor_2{i}(1,end);
end
group = [group_1;group_2];
G = graph(adjacency_matrix);
bins = conncomp(G);
% col vector
bins = bins';
k_clusters = length(unique(bins));
clusters = cell(k_clusters,1);
for clu = 1:k_clusters
    ind_clu = find(bins==clu);
    ind_less_len1 = find(ind_clu<=len_1);
    ind_greater_len1 = find(ind_clu>len_1);
    tmp_group_1 = [group(ind_clu(ind_less_len1)),ones(length(ind_clu(ind_less_len1)),1)];
    tmp_group_2 = [group(ind_clu(ind_greater_len1)),2*ones(length(ind_clu(ind_greater_len1)),1)];
    clusters{clu} = [tmp_group_1;tmp_group_2];
end
end