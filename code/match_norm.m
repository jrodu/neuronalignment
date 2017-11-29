function [ matchings ] = match_norm( points_original,points_new,dtheta,num_R )
n_old = size(points_original,2);
n_new = size(points_new,2);

[ features_old,~,~,~] = binc(points_original,dtheta,num_R);
[ features_new,~,~,~] = binc(points_new,dtheta,num_R);
disp(size(features_old))
% size(features_new)
%normalize?

matchings = zeros(n_old,2);
scores = zeros(n_old,n_new);
for i = 1:n_old
    for j = 1:n_new
        scores(i,j) = norm(features_old(i,:)-features_new(j,:));
    end
end
for i = 1:n_old
    [~,min_ind] = min(scores(i,:));
    matchings(i,1) = i;
    matchings(i,2) = min_ind;
end

end

