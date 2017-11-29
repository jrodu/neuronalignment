function [clusters,uni_indiv,idx_clusters] = k_means_cluster(coor_1,coor_2,k)
% [~,k] = unique_pairs(pairs);
% k = floor(0.8*k);
% [uni_indiv,len_1,len_2] = unique_individuals(pairs);
len_1 = length(coor_1);
len_2 = length(coor_2);
% uni_indiv: 1~len_1 corresponds to group1, len_1+1~len_1+len_2 group 2
uni_indiv = zeros(len_1+len_2,1);
for i = 1:len_1
    uni_indiv(i) = coor_1{i}(1,end);
end
for i = 1:len_2
    uni_indiv(i+len_1) = coor_2{i}(1,end);
end
% get coordinates of each uni_indiv
uni_indiv_coor = zeros(len_1+len_2,2);
for i = 1:len_1
    uni_indiv_coor(i,:) = coor_1{uni_indiv(i)}(:,1)';
end
for i = (len_1+1):(len_1+len_2)
    uni_indiv_coor(i,:) = coor_2{uni_indiv(i)}(:,1)';
end
idx_clusters = kmeans(uni_indiv_coor,k);
% initialize clusters
clusters = cell(k,1);
for clu = 1:k
    
    ind_clu = find(idx_clusters==clu);
    ind_less_len1 = find(ind_clu <= len_1);
    ind_greater_len1 = find(ind_clu > len_1);
    tmp_group_1 = [uni_indiv(ind_clu(ind_less_len1)),ones(length(ind_less_len1),1)];
    tmp_group_2 = [uni_indiv(ind_clu(ind_greater_len1)),2*ones(length(ind_greater_len1),1)];
    clusters{clu} = [tmp_group_1;tmp_group_2];
end
end