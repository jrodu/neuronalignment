% all ellipses centers are in the rectangle below
clf
axis equal
hold on
% rectangle('Position',[1 1 1 1])
% rectangle('Position',[2.5 1 1 1])
axis([0 27 0 27])
% number of ellipses
N_ell = 30;
% number of points in each ellipse
n = 100;
% noise parameters
% n_drop = 20;
% n_add = 20;
% create a cell to store data points of N_ell ellipse
ell_data = cell(N_ell+n_add,1);
% sd_pos = 0;
% var_rot = (pi/2)^2;
% var_el_coef = 0;
% sd_pos = 0.7;
% mu_rot = pi/6;
% mu_el = 1.4;
var_noise_boundary = 0;
% setup the size of each member in ell_data cell and generate center for
% each ellipse
mean_size = 0;
for i = 1:N_ell+n_add
%     last column records the No.of neurons
    ell_data{i} = zeros(2,n+2);
%     rng(i+1);
    ell_data{i}(1,1) = 10*rand + 1;
%     rng(i*i);
    ell_data{i}(2,1) = 10*rand + 1;
    ell_data{i}(1,end) = i;
end
% generate long and short radius of ellipses, a;b respectively
size_ellipse = zeros(2,N_ell+n_add);
for i = 1:N_ell+n_add
    size_ellipse(1,i) = unifrnd(0.5,0.8);
    tmp = size_ellipse(1,i);
    size_ellipse(2,i) = unifrnd(tmp,1);
    mean_size = mean_size+size_ellipse(2,i);
end
mean_size = mean_size/(N_ell+n_add);
% generate data points on ellipse boundary of N_ell ellipses according to
% size_ellipse
t = linspace(-pi,pi,n);
for i = 1:N_ell+n_add
    for j = 2:(n+1)
        ell_data{i}(1,j) = ell_data{i}(1,1) + size_ellipse(1,i)*cos(t(j-1));
        ell_data{i}(2,j) = ell_data{i}(2,1) + size_ellipse(2,i)*sin(t(j-1));
    end
    ell_data{i}(:,1) = mean(ell_data{i}(:,2:end-2),2);
end

% add noise

% neurons group 2
rotate_center = [1.5;1.5];
% rotate_theta = pi/6;
% translation = [12;12];
rotate_theta=0;
translation = [0;0];

% rotate_matrix = eye(2);
rotate_matrix = [cos(rotate_theta),-sin(rotate_theta);sin(rotate_theta),cos(rotate_theta)];
ell_data_2 = ell_data;

% add elongation noise

for i = 1:N_ell+n_add
    elong = normrnd(mu_el,0.1);
    for j = 2:length(ell_data_2{i}(1,:))-2
        ell_data_2{i}(2,j) = ell_data_2{i}(2,1)+(1+elong)*(ell_data_2{i}(2,j)-ell_data_2{i}(2,1));
    end
    ell_data_2{i}(2,1) = mean(ell_data_2{i}(2,2:end-2));
end

for i = 1:N_ell+n_add
%     adding noise to the center of neurons
    noise_x = normrnd(0,sd_pos);
%         rng(i+1);
    noise_y = normrnd(0,sd_pos);
    
    rotate_matrix = [cos(rotate_theta),-sin(rotate_theta);sin(rotate_theta),cos(rotate_theta)];
    for j = 2:(n+1)
        ell_data_2{i}(:,j) = rotate_matrix*(ell_data_2{i}(:,j) - rotate_center) + rotate_center + translation + [noise_x;noise_y];
    end
    ell_data_2{i}(:,1) = mean(ell_data_2{i}(:,2:end-2),2);
%     additional self rotation noise
    noise_rot = normrnd(mu_rot,pi/24);
    add_rotate = [cos(noise_rot),-sin(noise_rot);sin(noise_rot),cos(noise_rot)];
    for j = 2:(n+1)
        ell_data_2{i}(:,j) = add_rotate*(ell_data_2{i}(:,j) - ell_data_2{i}(:,1)) + ell_data_2{i}(:,1);
    end
    ell_data_2{i}(:,1) = mean(ell_data_2{i}(:,2:end-2),2);
end

% changes to initial points for each neuron
% ell_data_2_sub = ell_data_2;

% for i = 1:N_ell
% %     rng(i);
%     k = randi([3,n],1);
%     ell_data_2{i}(:,2:n-k+2) = ell_data_2_sub{i}(:,k:n);
%     ell_data_2{i}(:,n-k+3:n) = ell_data_2_sub{i}(:,2:k-1);
%     ell_data_2{i}(:,n+1) = ell_data_2_sub{i}(:,k);
%     
% %     % select polygon from ellipses
% %     num_poly = randi([num_poly_lower,num_poly_upper]);
% %     selected_ind = sort(randsample(2:(n+1),num_poly),'ascend');
% %     keep_index = [1,selected_ind,selected_ind(1),n+2];
% %     ell_data_2{i} = ell_data_2{i}(:,keep_index);
% %     ell_data_2{i}(:,1) = [mean(ell_data_2{i}(1,2:end-1)),mean(ell_data_2{i}(2,2:end-1))];
% end


% drop neurons from group 2
ell_data = ell_data(1:N_ell);
ell_data_2 = ell_data_2([1:N_ell-n_drop,N_ell+1:N_ell+n_add]);

% add n_add neurons to ell_data_2


% % plot group 1
% for i = 1:N_ell
%     plot(ell_data{i}(1,2:end-1),ell_data{i}(2,2:end-1),'Color','k');
%     hold on
% end
% 
% % plot group 2
% for i = 1:N_ell-n_drop
%     plot(ell_data_2{i}(1,2:end-1),ell_data_2{i}(2,2:end-1),'Color','k');
%     hold on
% end
% 
% % text neuron centers by their numbers
% % group 1
% for i = 1:N_ell
%     text(ell_data{i}(1,1),ell_data{i}(2,1),num2str(ell_data{i}(1,end)),'Color','k')
% end
% % group 2
% for i = 1:N_ell-n_drop
%     text(ell_data_2{i}(1,1),ell_data_2{i}(2,1),num2str(ell_data_2{i}(1,end)),'Color','k')
% end