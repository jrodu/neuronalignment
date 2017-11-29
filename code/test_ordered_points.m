dtheta = pi/6;
num_R = 3;
unordered_points_1 = [0,0,0,1,3,2,4,5,6,6,6,5,4,3,2,1;3,2,4,5,6,6,6,5,4,3,2,1,0,0,0,1];
unordered_points_2 = 2*unordered_points_1;
ordered_points_1 = ordering_edge_points(unordered_points_1);
ordered_points_2 = ordering_edge_points(unordered_points_2);
plot(ordered_points_1(1,:),ordered_points_1(2,:));
hold on
plot(ordered_points_2(1,:),ordered_points_2(2,:));
[shape_matching_pairs,shape_cost] = two_shape_matching(ordered_points_1,ordered_points_2,dtheta,num_R);
[shape_matching_pairs_lin,shape_similarity_lin] = two_pointcloud_matching_intlinprog(unordered_points_1,unordered_points_2,dtheta,num_R);