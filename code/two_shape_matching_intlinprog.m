function [ matched_pairs,obj_max] = two_shape_matching_intlinprog(shape_1,shape_2,dtheta,num_R)
% loop starts from C_11 = 1,...,C_1n = 1
[~,dim] = size(shape_1);
obj = zeros(dim,1);
binc_1 = binc(shape_1,dtheta,num_R);
binc_2 = binc(shape_2,dtheta,num_R);
%     normalization of bincs
binc_1 = normr(binc_1);
binc_2 = normr(binc_2);
multi = binc_1*binc_2';
for i = 1:dim
%     if (i > 0.2*dim) && (i < 0.8*dim)
%         continue;
%     end
    C = zeros(dim);
    k = i;
    for j = 1:dim
        C(j,k) = 1;
        if k < dim
            k = k + 1;
        else
            break;
        end
    end
    if j < dim
        k = 1;
        for jj = (j+1):dim
            C(jj,k) = 1;
            k = k + 1;
        end
    end
    obj(i) = sum(sum(multi.*C));
end
[obj_max,index] = max(obj);
matched_pairs = zeros(dim,2);
matched_pairs(:,1) = 1:dim;
matched_pairs(1:(dim-index+1),2) = index:dim;
if index > 1
    matched_pairs((dim-index+2):dim,2) = 1:(index-1);
end
end