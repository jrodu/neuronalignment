n_drop_list = [0,5,10,15,20,25];
len_ndrop = length(n_drop_list);
center_noise_list = 0:0.1:0.7;
len_pos = length(center_noise_list);
theta_rot_list = 0:pi/12:pi/2;
% theta_rot_list = pi/4;
len_rot = length(theta_rot_list);
el_coef_list = 0:0.1:0.7;
% el_coef_list = 0.7;
len_el = length(el_coef_list);
thres_center = 1;
thres_simi_score = 0.01;
num = 10;

accuracy_drop = cell(num,1);
precision_drop = cell(num,1);
accuracy_pos = cell(num,1);
precision_pos = cell(num,1);
accuracy_rot = cell(num,1);
precision_rot = cell(num,1);
accuracy_elong = cell(num,1);
precision_elong = cell(num,1);
pos_prop = cell(num,1);
el = cell(num,1);

% len_match = zeros(len_ndrop,1);
% c_count = zeros(len_ndrop,1);
% for i_drop = 1:num
%     disp(i_drop)
%     accuracy_drop{i_drop} = 5*ones(len_ndrop,1);
%     precision_drop{i_drop} = 5*ones(len_ndrop,1);
%     for id = 1:len_ndrop
%         n_drop = n_drop_list(id);
%         var_noise = 0;
%         var_el_coef = 0;
%         var_rot = 0;
%         test_clusters;
%         accuracy_drop{i_drop}(id) = accuracy;
%         precision_drop{i_drop}(id) = precision;
%         len_match(id) = len_matching;
%         c_count(id) = correct_count;
%     end
% end

% for i_pos = 1:num
%     disp(i_pos)
%     accuracy_pos{i_pos} = zeros(len_pos,1);
%     pos_prop{i_pos} = zeros(len_pos,1);
%     for ip = 1:len_pos
%         var_noise = center_noise_list(ip);
%         n_drop = 0;
%         test_clusters;
%         pos_prop{i_pos}(ip) = sqrt(var_noise)/avgcdist(ell_data);
%         accuracy_pos{i_pos}(ip) = accuracy;
%         precision_pos{i_pos}(ip) = precision;
%     end
% end

% for i_rot = 1:num
%     disp(i_rot)
%     accuracy_rot{i_rot} = zeros(len_rot,1);
%     for ir = 1:len_rot
%         var_noise = 0;
%         n_drop = 0;
%         var_el_coef = 0;
%         var_rot = theta_rot_list(ir)^2;
%         test_clusters;
%         accuracy_rot{i_rot}(ir) = accuracy;
%         precision_rot{i_rot}(ir) = precision;
%     end
% end

for i_elong = 1:num
    disp(i_elong)
    accuracy_elong{i_elong} = zeros(len_el,1);
    precision_elong{i_elong} = zeros(len_el,1);
    el{i_elong} = zeros(len_el,1);
    for ie = 1:len_el
        var_noise = 0;
        n_drop = 0;
        var_rot = 0;
        var_el_coef = el_coef_list(ie);
        test_clusters;
        el{i_elong}(ie) = el_coef_list(ie)/mean_size;
        accuracy_elong{i_elong}(ie) = accuracy;
        precision_elong{i_elong}(ie) = precision;
    end
end