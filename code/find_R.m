%Find the largest of the distances between all pair of points
function max_dist = find_R( data_x, data_y)
    n = length(data_x);
    max_dist = norm([data_x(1),data_y(1)] - [data_x(2),data_y(2)]);
    for i = 1:n
        for j = 1:n
            dist = norm([data_x(i),data_y(i)] - [data_x(j),data_y(j)]);
            max_dist = max(dist,max_dist);
        end
    end
end
            
        