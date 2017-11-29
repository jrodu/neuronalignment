function [ dist ] = avgcdist( points )
% points: n*1 cell
points_len = length(points);
dist = Inf(length(points),1);
for i = 1:points_len
    j = 1;
    while j<=points_len
        if j==i
            j = j+1;
            continue
        end
        dist(i) = min(dist(i),sqrt(norm(points{i}(:,1)-points{j}(:,1))));
        j=j+1;
    end
end
dist = mean(dist);
end

