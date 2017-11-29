%Find the median of the distances between all pair of points
function unit = find_units(data_x,data_y)
    n = length(data_x);
    dist = zeros(n);
    for i = 1:n
        for j = 1:n
            dist(i,j) = norm([data_x(i),data_y(i)] - [data_x(j),data_y(j)]);
        end
    end
    dist = reshape(dist,[n^2,1]);
    unit = median(dist);
end