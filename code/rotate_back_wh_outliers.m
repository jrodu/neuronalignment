function [A,b,boolean,points_1_removed,points_2_removed] = rotate_back_wh_outliers(points_1,points_2,dtheta,num_R)
epsilon_1 = 0.5:0.01:1;
epsilon_2 = 0.5:0.01:1;
for i = 1:length(epsilon_1)
    for j = 1:length(epsilon_2)
        disp('i,j')
        disp(i)
        disp(j)
%         remain (1-epsilon)*all points for the two clouds
        [points_1_removed,points_2_removed] = remove_outlier(points_1,points_2,epsilon_1(i),epsilon_2(j));
        
        [lower_thres,upper_thres] = range_threshold(points_1_removed,points_2_removed,dtheta,num_R);
        num_thres = num_threshold(points_1_removed,points_2_removed);
        thres_list = linspace(lower_thres,upper_thres,num_thres);
        matching_int_withthres = cell(num_thres,1);
        matching_int_size = [];
%         det_A = [];
        k = length(thres_list)-1;
        while k >= floor((length(thres_list)-1)/2)
%             disp(k)
            [temp,~] = two_pointcloud_matching_intlinprog(points_1_removed,points_2_removed,dtheta,num_R,thres_list(k));
            matching_int_withthres{k} = temp;
            matching_int_size(k) = length(matching_int_withthres{k}(1,:));
            if matching_int_size(k) > 6
                [b,A] = rotate_back_reg(points_1_removed,points_2_removed,matching_int_withthres{k});
%                 det_A(k) = det(A);
                if abs(det(A)-1) <= 1e-4
                    boolean = 1;
                    return;
                end
            end
            k = k-1;
        end
    end
end
if i == length(epsilon_1) && j == length(epsilon_2)
    boolean = 0;
end
end