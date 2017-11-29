function [ coor ] = polar_coor(bound_points,grid_theta)
len_theta = length(grid_theta);
pp = cscvn(bound_points);
num_breaks = length(pp.breaks);
% coor = zeros(len_theta,2);
coor = cell(len_theta,1);
count = 0;
for i = 1:len_theta
    theta = grid_theta(i);
    root = cell(num_breaks-1,1);
    for equ = 1:(num_breaks-1)
%         x_t = poly2sym(pp.coefs(2*equ-1,:));
%         y_t = poly2sym(pp.coefs(2*equ,:));
        if theta==pi/2 || theta==1.5*pi
            coefficients = pp.coefs(2*equ-1,:);
        else
            coefficients = pp.coefs(2*equ,:) - pp.coefs(2*equ-1,:)*tan(theta);
        end
        root{equ} = roots(coefficients);
        len_roots_i = length(root{equ});
        if len_roots_i > 0
            empty_i_root = [];
            for i_root = 1:len_roots_i
                x_i_root = polyval(pp.coefs(2*equ-1,:),root{equ}(i_root));
                y_i_root = polyval(pp.coefs(2*equ,:),root{equ}(i_root));
                r_i_root = sqrt(x_i_root^2+y_i_root^2);
                if isreal(root{equ}(i_root))==0
                    empty_i_root = [empty_i_root;i_root];
                elseif root{equ}(i_root)-1e-5 < 0 || root{equ}(i_root)-1e-5 >= pp.breaks(equ+1) - pp.breaks(equ)
                    empty_i_root = [empty_i_root;i_root];
                end
                if abs(y_i_root/r_i_root - sin(theta))>1e-5 || abs(x_i_root/r_i_root - cos(theta))>1e-5
                    empty_i_root = [empty_i_root;i_root];
                end
            end
            root{equ}(empty_i_root) = [];
        end
    end
%     empty = cellfun('isempty',root);
%     root(empty)=[];
%     root = cell2mat(root);
    coor_x = [];
    coor_y = [];
    for equ = 1:(num_breaks-1)
        if isempty(root{equ})
            continue;
        end
        coor_x = [coor_x;mean(polyval(pp.coefs(2*equ-1,:),root{equ}))];
        coor_y = [coor_y;mean(polyval(pp.coefs(2*equ,:),root{equ}))];
    end
%     coor(i,1) = mean(coor_x);
%     coor(i,2) = mean(coor_y);
    coor{i} = [coor_x,coor_y];
%     disp('coor{i}')
%     disp(coor{i})
    if ~isempty(coor{i})
%         disp('i')
%         disp(i)
        count = count+1;
    end
end
% disp('count')
% disp(count)
end