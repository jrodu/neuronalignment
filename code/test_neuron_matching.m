elipse_generating;
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

[lower_thres,upper_thres] = range_threshold(points_1,points_2,dtheta,num_R);
num_thres = num_threshold(points_1,points_2);
thres_list = linspace(lower_thres,upper_thres,num_thres);
% set a large threshold value here to avoid most noise
thres = thres_list(end-2);
% points-cloud matching results using integer programming
[int_matching_pairs,~,int_c] = two_pointcloud_matching_intlinprog(points_1,points_2,dtheta,num_R,thres);
% solve rotation back matrix by regression
[b,A] = rotate_back_reg(points_1,points_2,int_matching_pairs);

% if abs(det(A)-1) < 0.03
%     disp('correct rotation matrix')
% else
%     disp('incorrect rotation matrix')
%     return
% end

% regression all neurons back according to A,b
ell_data_2_back = ell_data_2;
for i = 1:length(ell_data_2_back)
    ell_data_2_back{i}(:,1) = A'*ell_data_2{i}(:,1) + b'*ones(1,1);
    diff_i = ell_data_2_back{i}(:,1) - ell_data_2{i}(:,1);
    diff_i = repmat(diff_i,1,n+1);
    ell_data_2_back{i}(:,1:n+1) = ell_data_2{i}(:,1:n+1) + diff_i;
end

% close center pairs between ell_data and ell_data_2_back
thres_center = 0.01;
num_bound = 50;
matching_center = [];
for ind1 = 1:length(ell_data)
    for ind2 = 1:length(ell_data_2_back)
        if norm(ell_data{ind1}(:,1)-ell_data_2_back{ind2}(:,1)) <= thres_center
            matching_center = [matching_center;ell_data{ind1}(1,n+2),ell_data_2_back{ind2}(1,n+2),norm(ell_data{ind1}(:,1)-ell_data_2_back{ind2}(:,1))];
        end
    end
end

max_dist_center = max(matching_center(:,3));

% shape matching based on points on boundaries
[num_shape_pairs,~] = size(matching_center);
similarity_score = zeros(num_shape_pairs,5);
similarity_score(:,1:3) = matching_center;
matching_pairs = cell(num_shape_pairs,1);
fit_points_shape_1 = cell(num_shape_pairs,1);
fit_points_shape_2 = cell(num_shape_pairs,1);
selected_fit_points_shape_1 = cell(num_shape_pairs,1);
selected_fit_points_shape_2 = cell(num_shape_pairs,1);
obj_max = zeros(num_shape_pairs,1);
var_diff = zeros(num_shape_pairs,1);
range_1 = cell(num_shape_pairs,1);
range_2 = cell(num_shape_pairs,1);
diff_cscvn = cell(num_shape_pairs,1);
cscvn_1 = cell(num_shape_pairs,1);
cscvn_2 = cell(num_shape_pairs,1);
% start comparing shapes of close neurons
for i = 1:num_shape_pairs
    disp(i)
    for ind1 = 1:length(ell_data)
        if ell_data{ind1}(1,end) == matching_center(i,1)
            break;
        end
    end
    for ind2 = 1:length(ell_data_2_back)
        if ell_data_2_back{ind2}(1,end) == matching_center(i,2)
            break;
        end
    end
%     get points on the boundary
    points_shape_1 = ell_data{ind1}(:,2:end-1);
    points_shape_2 = ell_data_2_back{ind2}(:,2:end-1);
% %     fit cubicspline
%     cscvn_1{i} = cscvn(points_shape_1);
%     cscvn_2{i} = cscvn(points_shape_2);
%     ran_1 = [cscvn_1{i}.breaks(1),cscvn_1{i}.breaks(end)];
%     ran_2 = [cscvn_2{i}.breaks(1),cscvn_2{i}.breaks(end)];
%     range_1{i} = linspace(ran_1(1),ran_1(2),100);
%     range_2{i} = linspace(ran_2(1),ran_2(2),100);
%     fit_points_shape_1{i} = fnval(cscvn_1{i},range_1{i});
%     fit_points_shape_2{i} = fnval(cscvn_2{i},range_2{i});
%     
% %     sample uniform grid from fitted points
%     
%     index_fit_points_shape_1 = 1:1:99;
%     index_fit_points_shape_2 = 1:1:99;
% 
% %     points to be used to construct feature matrices
%     selected_fit_points_shape_1{i} = fit_points_shape_1{i}(:,index_fit_points_shape_1);
%     selected_fit_points_shape_2{i} = fit_points_shape_2{i}(:,index_fit_points_shape_2);  
%     
%     new try using online scripts!!!
    selected_fit_points_shape_1{i} = interparc(100,points_shape_1(1,:),points_shape_1(2,:),'csape')';
    selected_fit_points_shape_2{i} = interparc(100,points_shape_2(1,:),points_shape_2(2,:),'csape')';
    
%     matching based on selected points preserving orders
    [matching_pairs{i},obj_max(i)] = two_shape_matching_intlinprog(selected_fit_points_shape_1{i},selected_fit_points_shape_2{i},dtheta,num_R);
    similarity_score(i,4) = obj_max(i);
    center_1 = ell_data{ind1}(:,1);
    center_2 = ell_data_2_back{ind2}(:,1);
    dist_1 = zeros(n,1);
    dist_2 = zeros(n,1);
    for j = 1:n
        dist_1(j) = norm(ell_data{ind1}(:,j)-center_1);
        dist_2(j) = norm(ell_data_2_back{ind2}(:,j)-center_2);
    end
    var_1 = var(dist_1)/n;
    var_2 = var(dist_2)/n;
    var_diff(i) = abs(var_1-var_2);
    similarity_score(i,5) = var_diff(i);
end