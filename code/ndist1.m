%calculate the nearest point
function [ nn] = ndist1(x,y,point)
n = length(x);
dist = zeros(n,1);
for i = 1:n
    dist(i) = norm([x(i) y(i)]-point);
end
dist_sort = sort(dist,'ascend');
index = 2;

while 1
    if dist_sort(index) == dist_sort(index-1)
        index = index + 1;
    else
        break;
    end
end

for i = 1:n 
    if norm([x(i) y(i)] - point) == dist_sort(index)
        nn = i;
        break;
    end  
end

end