function [matching_pairs,obj] = cluster_matching(cluster_index,matching_pairs,similarity_score)
len = length(cluster_index);
similarities = similarity_score(cluster_index);
obj = -Inf;
[sorted_pairs,sorted_index] = sortrows(matching_pairs,1);
sorted_similarities = similarities(sorted_index);
% construct unique matching pairs

end