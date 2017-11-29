function [matched_pairs,cost] = two_shape_matching(ordered_points_1,ordered_points_2,dtheta,num_R)
    N = length(ordered_points_1(1,:));
    binc_1 = binc(ordered_points_1,dtheta,num_R);
    binc_2 = binc(ordered_points_2,dtheta,num_R);
    binc_1 = normr(binc_1);
    binc_2 = normr(binc_2);
    num_max_diag = zeros(N,1);
    ntheta = 2*pi/dtheta;
    dim = ntheta*num_R;
    binc_2_rot = zeros(N,ntheta*num_R);
    for i = 1:N
        if i>=2
            binc_2_rot(1:i-1,:) = binc_2(N-i+2:N,:);
            binc_2_rot(i:N,:) = binc_2(1:N-i+1,:);
        else
            binc_2_rot = binc_2;
        end
        multi = binc_1*binc_2_rot';
        max_multi = max(multi,[],2);
        for j = 1:N
            if max_multi(j) == multi(j,j)
                num_max_diag(i) = num_max_diag(i) + 1;
            end
        end
    end
    [~,index] = max(num_max_diag);
    matched_pairs = zeros(2,N);
    matched_pairs(1,:) = 1:1:N;
    if index == 1
        matched_pairs(2,:) = 1:1:N;
        cost = norm(binc_1-binc_2);
    else
        matched_pairs(2,1:index-1) = N-index+2:1:N;
        matched_pairs(2,index:N) = 1:1:N-index+1;
        binc_2_rot(1:index-1,:) = binc_2(N-index+2:N,:);
        binc_2_rot(index:N,:) = binc_2(1:N-index+1,:);
        cost = norm(binc_1-binc_2_rot);
    end
end