function [ bin,ite,ro,n1point] = binc(points,dtheta,num_R)
a = points(1,:);
b = points(2,:);
N = length(a);
R = find_R(a,b);
r_units = R/num_R;
n1point = [];%nearest point for each point
ntheta = 2*pi/dtheta;
bin = zeros(N,ntheta*num_R);%bin counts for each point
ite = zeros(N,N);
ro = [];
for i = 1:N
    point = [a(i) b(i)];
    n1point(i) = ndist1(a,b,point);
    if a(n1point(i)) - a(i) > 0
        rotation_theta = asin((b(n1point(i)) - b(i))/norm([a(n1point(i))-a(i) b(n1point(i))-b(i)]));
    else
        rotation_theta = pi + asin(-(b(n1point(i)) - b(i))/norm([a(n1point(i))-a(i) b(n1point(i))-b(i)]));
    end
    ro(i) = rotation_theta;
    for j = [1:i-1 i+1:N]
        if norm([a(j)-a(i),b(j)-b(i)]) < 1e-10
            continue
        end
%         disp('i')
%         disp(i)
%         disp('j')
%         disp(j)
        point_j = [(a(j)-a(i)) b(j)-b(i)]*[cos(-ro(i)) sin(-ro(i));-sin(-ro(i)) cos(-ro(i))];
%         disp('a(j)')
%         disp(a(j))
%         disp('b(j)')
%         disp(b(j))
        if norm(point_j) == 0
            normpoint_j = point_j;
        else
            normalpoint_j = point_j/norm(point_j);
        end
        dist = norm(point - [a(j) b(j)]);
        rad = floor((dist+eps)/r_units);
        if rad == num_R
            rad = num_R - 1;
        end
        if point_j(1) >= 0
            if point_j(2) >= 0
                theta = asin(normalpoint_j(2));
            else
                theta = asin(normalpoint_j(2)) + 2*pi;
            end
        else
            if point_j(2) >= 0
                theta = -asin(normalpoint_j(2)) + pi;
            else
                theta = asin(-normalpoint_j(2)) + pi;
            end
        end
        
        itheta = floor(theta/dtheta) + 1;
        ite(i,j) = theta;
        if j == n1point(i)
           theta = 0;
           itheta = 1;
           ite(i,j) = 0;
        end
%         disp('i,j')
%         disp([i,j])
%         disp('theta')
%         disp(theta)
        bin(i,ntheta*rad + itheta) = bin(i,ntheta*rad+itheta) + 1;

    end
end
end