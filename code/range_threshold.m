function [lower,upper] = range_threshold(points_1,points_2,dtheta,num_R)
binc_1 = binc(points_1,dtheta,num_R);
binc_2 = binc(points_2,dtheta,num_R);
% normalization of bincs
binc_1 = normr(binc_1);
binc_2 = normr(binc_2);
multi = binc_1*binc_2';
non_zeros_multi = nonzeros(multi);
lower = min(non_zeros_multi);
upper = max(non_zeros_multi);
end