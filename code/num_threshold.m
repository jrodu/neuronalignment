function [ num] = num_threshold(points_1,points_2)
num = floor(sqrt(length(points_1(1,:))*length(points_2(1,:))));
end