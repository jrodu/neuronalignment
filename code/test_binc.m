clf
axis equal
hold on
x1=1;
y1=1;
rc=1;
[x,y,z] = cylinder(rc,200);
plot(x(1,:)+x1,y(1,:)+y1,'r')
a = [];
b = [];
N = 20;
for t=1:N %loop until doing N points inside the circle
    [x y]=cirrdnPJ(x1,y1,rc);
    a(t) = x;
    b(t) = y;
    text(x,y,num2str(t),'Color','b')
end
dtheta = pi/6;
points = [a;b];
num_R = 3;
[ bin,ite,ro,n1point] = binc(points,dtheta,num_R);


% No.of points in each slide
c = zeros(N,2*pi/dtheta);
for i = 1:N
    for j = 1:(2*pi/dtheta)
        for k = 0:(num_R-1)
            c(i,j) = c(i,j) + bin(i,k*(2*pi/dtheta)+j);
        end
    end
end