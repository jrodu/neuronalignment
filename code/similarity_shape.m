function [ score] = similarity_shape(selected_shape_1,selected_shape_2,matched_pairs)
% matched_pairs: row_dim by 2
ind_1 = matched_pairs(:,1);
ind_2 = matched_pairs(:,2);
matched_shape_1 = selected_shape_1(:,ind_1);
matched_shape_2 = selected_shape_2(:,ind_2);
score = norm(matched_shape_1 - matched_shape_2, 'fro');
end