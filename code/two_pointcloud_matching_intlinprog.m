function [matched_pairs,similarity,c] = two_pointcloud_matching_intlinprog(points_1,points_2,dtheta,num_R,threshold)
    dim_1 = length(points_1(1,:));
    dim_2 = length(points_2(1,:));
    dim = dim_1*dim_2;
    binc_1 = binc(points_1,dtheta,num_R);
    binc_2 = binc(points_2,dtheta,num_R);
%     normalization of bincs
    binc_1 = normr(binc_1);
    binc_2 = normr(binc_2);
    multi = binc_1*binc_2';
    multi(multi < threshold) = 0;
%     filter is used to force c_ij = 0 if multi_ij = 0
    filter = multi;
    filter(filter >= threshold) = 1;
    multi_reshape = reshape(multi',[dim,1]);
    A = zeros(dim_1+dim_2,dim);
    for i = 1:dim_1
        for j = 1:dim_2
            A(i,(i-1)*dim_2+j) = 1;
        end
    end
    for i = 1:dim_2
        for j = 1:dim_1
            A(dim_1+i,(j-1)*dim_2+i) = 1;
        end
    end
    b = ones(dim_1+dim_2,1);
    lb = zeros(dim,1);
    ub = ones(dim,1);
    intcon = 1:dim;
    Aeq = [];
    beq = [];
    c = intlinprog(-multi_reshape,intcon,A,b,Aeq,beq,lb,ub);
    similarity = multi_reshape'*c;
    c = reshape(c,[dim_2,dim_1])';
%     filt c
    c = filter.*c;
    matched_pairs = [];
    count = 0;
    for i = 1:dim_1
        for j = 1:dim_2
            if c(i,j) == 1
                count = count + 1;
                matched_pairs(:,count) = [i;j];
            end
        end
    end
end