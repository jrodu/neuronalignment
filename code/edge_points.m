function [points] = edge_points(n)
%for an example, the edge is a circle with radius = 1, center = (1,1)
    u = 2*pi*rand(1,n);
    r = 1;
    a = r*cos(u) + 1;
    b = r*sin(u) + 1;
    points = [a;b];
end