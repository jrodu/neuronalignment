n_drop_list = 0:2:12;
n_add_list = n_drop_list;
len_ndrop = length(n_drop_list);
center_noise_list = 0:0.03:0.21;
len_pos = length(center_noise_list);
rot_list = 0:pi/24:pi/6;
len_rot = length(rot_list);
el_list = 1:0.05:1.2;
len_el = length(el_list);
thres_center = 0.7;
thres_simi_score = 0.25;
w_shape = 0.8;
w_dist = 0.2;
num = 10;

precision_list = zeros(len_ndrop,len_pos,len_rot,len_el);
recall_list = zeros(len_ndrop,len_pos,len_rot,len_el);
pos_prop = zeros(len_ndrop,len_pos,len_rot,len_el);

for i_drop = 3:3
    for i_pos = 5:5
        for i_rot = 1:1
            for i_el = 1:len_el
                sum_precision = 0;
                sum_recall = 0;
                for i = 1:num
                    n_drop = n_drop_list(i_drop);
                    n_add = n_add_list(i_drop);
                    sd_pos = center_noise_list(i_pos);
                    mu_rot = rot_list(i_rot);
                    mu_el = el_list(i_el);
                    test_clusters;
                    pos_prop(i_drop,i_pos,i_rot,i_el) = sd_pos/avgcdist(ell_data);
                    sum_precision = sum_precision+precision;
                    sum_recall = sum_recall+accuracy;
                end
                precision_list(i_drop,i_pos,i_rot,i_el) = sum_precision/num;
                recall_list(i_drop,i_pos,i_rot,i_el) = sum_recall/num;
            end
        end
    end
end