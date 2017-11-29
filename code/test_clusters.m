% elipse_generating;
% do points-cloud matching for neuron centers between group1 and group2
n1 = length(ell_data);
n2 = length(ell_data_2);
points_1 = zeros(2,n1);
points_2 = zeros(2,n2);

for i = 1:n1
    points_1(:,i) = ell_data{i}(:,1);
end
for i = 1:n2
    points_2(:,i) = ell_data_2{i}(:,1);    
end
% parameters setting
dtheta = pi/6;
num_R = 3;
% thres_reg = 0.2;

[lower_thres,upper_thres] = range_threshold(points_1,points_2,dtheta,num_R);
num_thres = num_threshold(points_1,points_2);
thres_list = linspace(lower_thres,upper_thres,num_thres);
% set a large threshold value here to avoid most noise
thres_index = floor(0.8*num_thres):num_thres;
% thres_index = floor(0.8*num_thres):floor(0.98*num_thres);
len_thres_index = length(thres_index);
thres = thres_list(thres_index(1));
[int_matching_pairs,~,int_c] = two_pointcloud_matching_intlinprog(points_1,points_2,dtheta,num_R,thres);
[b_tmp,A_tmp] = rotate_back_reg(points_1,points_2,int_matching_pairs);
dist_A_tmp = abs(det(A_tmp)-1);
A = A_tmp;
b = b_tmp;
dist_A = dist_A_tmp;
for ind = 1:len_thres_index
    thres = thres_list(thres_index(ind));
    [int_matching_pairs,~,int_c] = two_pointcloud_matching_intlinprog(points_1,points_2,dtheta,num_R,thres);
    [b_tmp,A_tmp] = rotate_back_reg(points_1,points_2,int_matching_pairs);
    dist_A_tmp = abs(det(A_tmp)-1);
    if dist_A_tmp < dist_A
        dist_A = dist_A_tmp;
        A = A_tmp;
        b = b_tmp;
    end
end

% thres = thres_list(end-2);
% % points-cloud matching results using integer programming
% [int_matching_pairs,~,int_c] = two_pointcloud_matching_intlinprog(points_1,points_2,dtheta,num_R,thres);
% % solve rotation back matrix by regression
% [b,A] = rotate_back_reg(points_1,points_2,int_matching_pairs);

if abs(det(A)-1) < thres_reg
    disp('correct rotation matrix')
else
    disp('incorrect rotation matrix')
    accuracy = 0;
    precision = 0;
    len_matching = 0;
    correct_count = 0;
    return
end


% regression all neurons back according to A,b
ell_data_2_back = ell_data_2;
for i = 1:length(ell_data_2_back)
    [~,n] = size(ell_data_2_back{i});
    n = n-2;
%     ell_data_2_back{i}(:,1) = A'*ell_data_2{i}(:,1) + b'*ones(1,1);
%     diff_i = ell_data_2_back{i}(:,1) - ell_data_2{i}(:,1);
%     diff_i = repmat(diff_i,1,n+1);
%     ell_data_2_back{i}(:,1:n+1) = ell_data_2{i}(:,1:n+1) + diff_i;
    ell_data_2_back{i}(:,2:n+1) = A'*ell_data_2{i}(:,2:n+1) + b'*ones(1,n);
    ell_data_2_back{i}(:,1) = mean(ell_data_2_back{i}(:,2:n),2);
end


% globally optimization
% thres_center = 1;
% thres_simi_score = 5;
delta_theta = pi/12;
grid_theta = 0:delta_theta:2*pi-delta_theta;
% w_shape = 0.5;
% w_dist = 0.5;

% get adjacency matrix
[adjacency] = construct_adjacency(ell_data,ell_data_2_back,thres_center);
adj_clusters = adjacency_cluster(adjacency,ell_data,ell_data_2_back);
[matching_results_adj] = matching_SSE(adj_clusters,ell_data,ell_data_2_back,thres_center,grid_theta,w_shape,w_dist,thres_simi_score);
% because some clusters contain only 1 point, so no matching results
empty = cellfun('isempty',matching_results_adj);
matching_results_adj(empty)=[];
matching_results_adj_matrix = cell2mat(matching_results_adj);
matching_results_adj_matrix = sortrows(matching_results_adj_matrix,3);

% accuracy
% [len_matching,~] = size(matching_results_adj_matrix);
% correct_count = 0;
% for i = 1:len_matching
%     if matching_results_adj_matrix(i,2)<=(N_ell-n_drop) && matching_results_adj_matrix(i,1) == matching_results_adj_matrix(i,2)
%         correct_count = correct_count + 1;
%     end
% end
% if len_matching>0
%     matching_results_adj_matrix = sortrows(matching_results_adj_matrix,3);
%     precision = correct_count/len_matching;
% else
%     precision = 0;
% end
% 
% accuracy = correct_count/(N_ell-n_drop);


% % plot group 1
% for i = 1:N_ell
%     plot(ell_data{i}(1,2:end-1),ell_data{i}(2,2:end-1),'Color','k');
%     hold on
% end
% 
% % plot group 2
% for i = 1:N_ell-n_drop
%     plot(ell_data_2{i}(1,2:end-1),ell_data_2{i}(2,2:end-1),'Color','k');
%     hold on
% end
% 
% for i = 1:N_ell-n_drop
%     plot(ell_data_2_back{i}(1,2:end-1),ell_data_2_back{i}(2,2:end-1),'Color','b');
%     hold on
% end
% % text neuron centers by their numbers
% % group 1
% for i = 1:N_ell
%     text(ell_data{i}(1,1),ell_data{i}(2,1),num2str(ell_data{i}(1,end)),'Color','k')
% end
% % group 2
% for i = 1:N_ell-n_drop
%     text(ell_data_2{i}(1,1),ell_data_2{i}(2,1),num2str(ell_data_2{i}(1,end)),'Color','k')
% end
