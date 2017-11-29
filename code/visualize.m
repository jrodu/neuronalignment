clf
axis equal
hold on
axis([0 12 0 12])
N_ell = 30;
n = 100;
n_drop = 0;
n_add = 0;
sd_pos = 0;
mu_rot = pi/2;
mu_el = 0.5;
ell_data = cell(N_ell+n_add,1);
rng(1)
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
%     mean_size = mean_size+size_ellipse(2,i);
end
% mean_size = mean_size/(N_ell+n_add);
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

ell_data_2 = ell_data;

% for i = 1:N_ell+n_add
%     elong = normrnd(mu_el,0.1);
%     for j = 2:length(ell_data_2{i}(1,:))-2
%         ell_data_2{i}(2,j) = ell_data_2{i}(2,1)+(1+elong)*(ell_data_2{i}(2,j)-ell_data_2{i}(2,1));
%     end
%     ell_data_2{i}(2,1) = mean(ell_data_2{i}(2,2:end-2));
% end

for i = 1:N_ell+n_add
%     adding noise to the center of neurons
    noise_x = normrnd(0,sd_pos);
%         rng(i+1);
    noise_y = normrnd(0,sd_pos);
    
    for j = 2:(n+1)
        ell_data_2{i}(:,j) = ell_data_2{i}(:,j) + [noise_x;noise_y];
    end
    ell_data_2{i}(:,1) = mean(ell_data_2{i}(:,2:end-2),2);
% %     additional self rotation noise
%     noise_rot = normrnd(mu_rot,pi/24);
%     add_rotate = [cos(noise_rot),-sin(noise_rot);sin(noise_rot),cos(noise_rot)];
%     for j = 2:(n+1)
%         ell_data_2{i}(:,j) = add_rotate*(ell_data_2{i}(:,j) - ell_data_2{i}(:,1)) + ell_data_2{i}(:,1);
%     end
%     ell_data_2{i}(:,1) = mean(ell_data_2{i}(:,2:end-2),2);
end

ell_data = ell_data(1:N_ell);
ell_data_2 = ell_data_2([1:N_ell-n_drop,N_ell+1:N_ell+n_add]);

% plots
% figure(1)
% for i = 1:N_ell
%     plot(ell_data{i}(1,2:end-1),ell_data{i}(2,2:end-1),'Color','k');
%     hold on
%     text(ell_data{i}(1,1),ell_data{i}(2,1),num2str(ell_data{i}(1,end)),'Color','k')
%     hold on
% end
% figure(1)
% for i = 1:N_ell-n_drop+n_add
%     plot(ell_data_2{i}(1,2:end-1),ell_data_2{i}(2,2:end-1),'Color','r');
%     hold on
%     text(ell_data_2{i}(1,1),ell_data_2{i}(2,1),num2str(ell_data_2{i}(1,end)),'Color','r')
%     hold on
% end
% 
% xlabel('','FontSize',20,'Interpreter','Latex')
% ylabel('','FontSize',20,'Interpreter','Latex')
% set(gca,'FontSize',20);

figure(1)
for i = 1:N_ell-n_drop
    plot(ell_data{i}(1,2:end-1),ell_data{i}(2,2:end-1),'Color','k');
    hold on
    text(ell_data{i}(1,1),ell_data{i}(2,1),num2str(ell_data{i}(1,end)),'Color','k')
    hold on
end
figure(1)
for i = N_ell-n_drop+1:N_ell-n_drop+n_add
    plot(ell_data_2{i}(1,2:end-1),ell_data_2{i}(2,2:end-1),'Color','r');
    hold on
    text(ell_data_2{i}(1,1),ell_data_2{i}(2,1),num2str(ell_data_2{i}(1,end)),'Color','r')
    hold on
end

xlabel('','FontSize',20,'Interpreter','Latex')
ylabel('','FontSize',20,'Interpreter','Latex')
set(gca,'FontSize',20);