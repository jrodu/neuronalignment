% matched pairs should be listed top to bottom,using translation and
% rotation separately
function [ mean_diff, theta ] = rotate_back(points_1,points_2,matched_pairs)
len = length(matched_pairs(:,1));
points_1 = points_1';
points_2 = points_2';
mean_intgoodmatch_points_1 = mean(points_1(matched_pairs(:,1),:));
mean_intgoodmatch_points_2 = mean(points_2(matched_pairs(:,2),:));
mean_diff = mean_intgoodmatch_points_2 - mean_intgoodmatch_points_1;
x1 = points_1(matched_pairs(:,1),1);
x2 = points_2(matched_pairs(:,2),1);
y1 = points_1(matched_pairs(:,1),2);
y2 = points_2(matched_pairs(:,2),2);
x2 = x2 - mean_diff(1);
y2 = y2 - mean_diff(2);
top = 0;
bottom = 0;
meanx2 = mean(x2);
meany2 = mean(y2);
for i = 1:len
    top = top + (x1(i)-meanx2)*(y2(i)-meany2) - (y1(i)-meany2)*(x2(i)-meanx2);
    bottom = bottom + (x1(i)-meanx2)*(x2(i)-meanx2)+(y1(i)-meany2)*(y2(i)-meany2);
end
theta = atan(-top/bottom);
end