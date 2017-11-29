function [ordered_points] = ordering_edge_points(points)
    n = length(points(1,:));
    temp_points_set = points;
    ordered_points = zeros(2,n);
    ordered_points(:,1) = points(:,1);
    num = 1;
    while num<n
        index = ndist1(temp_points_set(1,:),temp_points_set(2,:),ordered_points(:,num)');
        ordered_points(:,num+1) = temp_points_set(:,index);
        for i = 1:length(temp_points_set(1,:))
            if temp_points_set(:,i) == ordered_points(:,num)
                break;
            end
        end
        temp_points_set(:,i) = [];
        num = num+1;
    end
end       