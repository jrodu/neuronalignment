%create two point clouds
clf
axis equal
hold on
rectangle('Position',[1 1 1 1])
axis([0.5 4 0.5 4])
%number of points in point-cloud
N = 100;
n_except = 30;
n_add = 0;
n_add_outsquare = 0;
n_duplicate = 0;
noise = 0.01;
% other parameters
dtheta = pi/6;
num_R = 3;
% added points are outside the original square
out_radius = 2;
a_1 = zeros(N,1);
a_2 = zeros(N,1);
b_1 = zeros(N,1);
b_2 = zeros(N,1);
points_1 = zeros(2,N);
points_2_old = zeros(2,N);
%rotate points_1 by rotate_theta
rotate_theta = pi/6;
rotate_matrix = [cos(rotate_theta),-sin(rotate_theta);sin(rotate_theta),cos(rotate_theta)];
for i = 1:N
    a_1(i) = rand+1;
    b_1(i) = rand+1;
%     draw drop points from points_1 in a different color
    if n_except > 0 && i >= N-n_except+1
        text(a_1(i),b_1(i),num2str(i),'Color','k')
    else
        text(a_1(i),b_1(i),num2str(i),'Color','b')
    end
    points_1(:,i) = [a_1(i);b_1(i)];
    points_2_old(:,i) = rotate_matrix*(points_1(:,i)-[1.5;1.5])+[1.5;1.5];
%    translation
    points_2_old(:,i) = points_2_old(:,i) + [1;1];
end

% delete last n_except points after rotation
points_2 = points_2_old(:,1:N-n_except);

% add n_add points inside the square after rotation
if n_add >= 1
    add_points = zeros(2,n_add);
    for i = 1:n_add
%         here shows the way adding new points uniformly or un-uniformly in
%         the square
        add_points(:,i) = [rand+1;rand+1];
        add_points(:,i) = rotate_matrix*(add_points(:,i)-[1.5;1.5])+[1.5;1.5] + [1;1];
    end
    points_2 = [points_2,add_points];
end

% add n_add_outsquare points outside the square after rotation
if n_add_outsquare >= 1
    add_outsquare_points = zeros(2,n_add_outsquare);
    for i = 1:n_add_outsquare
        add_outsquare_points(:,i) = [unifrnd(1-out_radius,1);unifrnd(1-out_radius,2+out_radius)];
        add_outsquare_points(:,i) = rotate_matrix*(add_outsquare_points(:,i)-[1.5;1.5])+[1.5;1.5] + [1;1];
    end
    points_2 = [points_2,add_outsquare_points];
end

% duplicate points for points_2
if n_duplicate > 0
    points_duplicate = zeros(2,n_duplicate);
    for i = 1:n_duplicate
        points_duplicate(:,i) = rotate_matrix*(points_2(:,i)-[2.5;2.5]) + [2.5;2.5];
    end 
    points_2 = [points_2, points_duplicate];
end

% add noise to points_2
if noise > 0
    for i = 1:length(points_2(1,:))
        points_2(1,i) = points_2(1,i) + normrnd(0,noise);
        points_2(2,i) = points_2(2,i) + normrnd(0,noise);
    end
end

% plot final points_2
for i = 1:(length(points_1)-n_except)
    text(points_2(1,i),points_2(2,i),num2str(i),'Color','r')
end
for i = (length(points_1)-n_except+1):(length(points_1)-n_except+n_add)
    text(points_2(1,i),points_2(2,i),num2str(i),'Color','m')
end
for i = (length(points_1)-n_except+n_add+1):(length(points_1)-n_except+n_add+n_add_outsquare)
    text(points_2(1,i),points_2(2,i),num2str(i),'Color','g')
end
for i = (length(points_1)-n_except+n_add+n_add_outsquare+1):length(points_2)
    text(points_2(1,i),points_2(2,i),num2str(i),'Color','k')
end
%finished creating point clouds points_1,points_2
if n_except > 0
    if n_add > 0
        str = strcat(num2str(noise),'noise',',','add','',num2str(n_add),',','drop','',num2str(n_except));
    else
        str = strcat(num2str(noise),'noise',',','drop','',num2str(n_except));
    end
elseif n_add > 0
    str = strcat(num2str(noise),'noise',',','add','',num2str(n_add));
else
    str = strcat(num2str(noise),'noise');
end
title(str);

% this part is to drop important points in a loop until the number of
% matching pairs is less than 6. (using points_1, points_2)
% num_matching_pairs_imp = min(length(points_1(1,:)),length(points_2(1,:)));
% det_A_imp = min(1,1);
% ind = 1;
% % number of points to be dropped in each while loop
% num_drop = 3;
% % check matching pairs helper
% count_equals = 1;
% while(num_matching_pairs_imp(ind) > 6)
%     ind = ind + 1;
%     [lower_thres_imp,upper_thres_imp] = range_threshold(points_1,points_2,dtheta,num_R);
%     num_thres_imp = num_threshold(points_1,points_2);
%     thres_list_imp = linspace(lower_thres_imp,upper_thres_imp,num_thres_imp);
%     % set thres_imp to a large value for a proper rotation matrix A_imp
%     thres_imp = thres_list_imp(end-1);
%     [int_matching_pairs_imp,~] = two_pointcloud_matching_intlinprog(points_1,points_2,dtheta,num_R,thres_imp);
%     if abs(norm(int_matching_pairs_imp(1,:)-int_matching_pairs_imp(2,:))) <= 1e-5
%         count_equals(ind) = 1;
%     else
%         count_equals(ind) = 0;
%     end
%     num_tmp = length(int_matching_pairs_imp(1,:));
%     num_matching_pairs_imp(ind) = num_tmp;
%     [~,A_imp] = rotate_back_reg(points_1,points_2,int_matching_pairs_imp);
%     det_A_imp(ind) = det(A_imp);
% %     index of int_matching_pairs_imp to be dropped
%     drop_points_matching_ind = randsample(num_tmp,num_drop);
%     drop_points_ind = int_matching_pairs_imp(:,drop_points_matching_ind);
% %     update points_1, points_2 by dropping important points from 1&2
% %     respectively
%     points_1(:,drop_points_ind(1,:)) = [];
%     points_2(:,drop_points_ind(2,:)) = [];
% end
% figure(2);
% plot(num_matching_pairs_imp(2:end-1));
% xlabel('num-loop');
% ylabel('num-matching-pairs');
% % title('drop important points');
% figure(3);
% plot(det_A_imp(2:end-1));
% ylim([0.8,1.2]);
% xlabel('num-loop');
% ylabel('det(A)');
% % title('drop important points')

% % % % % % % % % % % % % % %end this part % % %%%%%%%%%%%%%%%%%%%%%%%%%


% %calculating the matched pairs and the similarity between two clouds
% threshold = 0;
% %integer programming
% [int_matching_pairs,similarity_lin] = two_pointcloud_matching_intlinprog(points_1,points_2,dtheta,num_R,threshold);
% %transpose int_matching_pairs matrix
% int_matching_pairs = int_matching_pairs';
% %for each point in point_1, find the nearest row in point_2
% [norm_matching_result,cost_norm] = two_pointcloud_matching_norm_unique(points_1,points_2,dtheta,num_R);
% 
% %accuracy
% count_opt = 0;
% count_norm = 0;
% for i = 1:length(int_matching_pairs)
%     if int_matching_pairs(i,1) ~= int_matching_pairs(i,2)
%         count_opt = count_opt+1;
%     end
% end
% for i = 1:length(norm_matching_result)
%     if norm_matching_result(i,1) ~= norm_matching_result(i,2)
%         count_norm = count_norm + 1;
%     end
% end
% 
% % % translate back using good match pairs
% % [translation_back,rotate_back_theta] = rotate_back(points_1,points_2,norm_matching_result);
% % % translate back using regression y = Ax + b, no noise here. A is
% % % approximately the rotation matrix.
% % [b,A] = rotate_back_reg(points_1,points_2,norm_matching_result);
% 


% relationship between threshold and #matching_pairs using intlinprog
[lower_thres,upper_thres] = range_threshold(points_1,points_2,dtheta,num_R);
num_thres = num_threshold(points_1,points_2);
thres_list = linspace(lower_thres,upper_thres,num_thres);
matching_int_withthres = cell(num_thres,1);
% except the last in thres_list to prevent singular matrix
matching_int_size = [];
det_A = [];
for i = 1:(length(thres_list)-1)
    disp(i)
    [temp,~] = two_pointcloud_matching_intlinprog(points_1,points_2,dtheta,num_R,thres_list(i));
    matching_int_withthres{i} = temp;
    matching_int_size(i) = length(matching_int_withthres{i}(1,:));
    [~,A] = rotate_back_reg(points_1,points_2,matching_int_withthres{i});
    det_A(i) = det(A);
    if matching_int_size(i) <= 6
        break;
    end
end
% matching_int_size = matching_int_size(matching_int_size ~= 0);
det_A = det_A(det_A ~= 0);
if matching_int_size(end) <= 4
    det_A = det_A(1:end-1);
    matching_int_size = matching_int_size(1:end-1);
end
figure
plot(thres_list(1:length(det_A)),det_A);
xlabel('threshold')
ylabel('det(A)')
ylim([min(min(det_A),0.5),max(max(det_A),1.1)])
title(str)
% subplot(1,2,1);
% % plot(matching_int_size);
% plot(thres_list(1:length(matching_int_size)),matching_int_size);
% xlabel('threshold')
% ylabel('size of matching pairs')
% ylim([0,100]);
% subplot(1,2,2);
% plot(thres_list(1:length(det_A)),det_A);
% xlabel('threshold')
% ylabel('det(A)')
% % ylim([min([0,min(det_A),min(det_A)/2,min(det_A)*2]),max([0,max(det_A),max(det_A)/2,max(det_A)*2])])
% currentFigure = gcf;
% title(currentFigure.Children(end),'duplicate20');



%%%%%%%%%%%%%%%%%%%for n_add_outsquare=0,comment from here%%%%%%%%%%%%%%%%%%%%
% [points_1_removed,points_2_removed] = remove_outlier(points_1,points_2,0.5,0.5);
% med_1 = [median(points_1(1,:));median(points_1(2,:))];
% med_2 = [median(points_2(1,:));median(points_2(2,:))];
% med_1_removed = [median(points_1_removed(1,:));median(points_1_removed(2,:))];
% med_2_removed = [median(points_2_removed(1,:));median(points_2_removed(2,:))];
% clf
% axis equal
% hold on
% rectangle('Position',[1 1 1 1])
% axis([0.5 4 0.5 4])
% for i = 1:length(points_1_removed(1,:))
%     text(points_1_removed(1,i),points_1_removed(2,i),num2str(i),'Color','b')
% end
% for i = 1:length(points_2_removed(1,:))
%     text(points_2_removed(1,i),points_2_removed(2,i),num2str(i),'Color','r')
% end
% [A_whoutliers,~,boolean,~,~] = rotate_back_wh_outliers(points_1,points_2,dtheta,num_R);