function [b,A] = rotate_back_reg(points_1,points_2,matching_pairs)
% detect if the matching_pairs, points matrix need to be inversed
dim = 2;
if length(matching_pairs(:,1)) == dim
    matching_pairs = matching_pairs';
end
if length(points_1(:,1)) == dim
    points_1 = points_1';
end
if length(points_2(:,1)) == dim
    points_2 = points_2';
end
% % remove bad matching_pairs, in noiseless case here, it means not equal
% for i = 1:length(matching_pairs(:,1));
%     if matching_pairs(i,1) ~= matching_pairs(i,2)
%         matching_pairs(i,:) = [];
%     end
% end
points_1 = points_1(matching_pairs(:,1),:);
points_2 = points_2(matching_pairs(:,2),:);
% regression model: points_1 = [points_2,1]*[A;b], b: 1*2
len_2 = length(points_2(:,1));
% design matrix
Z = [points_2,ones(len_2,1)];
beta = (Z'*Z)\Z'*points_1;
b = beta(end,:);
A = beta(1:dim,:);
end