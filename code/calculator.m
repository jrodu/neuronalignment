mean_acc_drop = zeros(length(n_drop_list),1);
mean_pre_drop = zeros(length(n_drop_list),1);
for i = 1:length(n_drop_list)
    for i_cell = 1:num
        mean_acc_drop(i) = mean_acc_drop(i)+accuracy_drop{i_cell}(i);
        mean_pre_drop(i) = mean_pre_drop(i)+precision_drop{i_cell}(i);
    end
    mean_acc_drop(i) = mean_acc_drop(i)/num;
    mean_pre_drop(i) = mean_pre_drop(i)/num;
end
prop_drop_list = n_drop_list/30;
plot(1-prop_drop_list,mean_acc_drop,'LineWidth',2);
hold on
plot(1-prop_drop_list,mean_pre_drop,'LineWidth',2);
xlabel('prop\_overlap','FontSize',20,'Interpreter','Latex')
ylabel('recall or precision','FontSize',20,'Interpreter','Latex')
h_legend=legend('recall','precision','Location','northeast');
set(h_legend,'FontSize',15);
set(gca,'FontSize',20);

% mean_pos = zeros(length(center_noise_list),1);
% mean_acc_pos = zeros(length(center_noise_list),1);
% mean_pre_pos = zeros(length(center_noise_list),1);
% for i = 1:length(center_noise_list)
%     for i_cell = 1:num
%         mean_pos(i) = mean_pos(i)+pos_prop{i_cell}(i);
%         mean_acc_pos(i) = mean_acc_pos(i)+accuracy_pos{i_cell}(i);
%         mean_pre_pos(i) = mean_pre_pos(i)+precision_pos{i_cell}(i);
%     end
%     mean_pos(i) = mean_pos(i)/num;
%     mean_acc_pos(i) = mean_acc_pos(i)/num;
%     mean_pre_pos(i) = mean_pre_pos(i)/num;
% end
% % mean_acc_pos(end) = 0.05;
% plot(mean_pos,mean_acc_pos,'LineWidth',2)
% hold on
% plot(mean_pos,mean_pre_pos,'LineWidth',2)
% xlabel('prop\_pos','FontSize',20,'Interpreter','Latex')
% ylabel('recall','FontSize',20,'Interpreter','Latex')
% h_legend=legend('recall','precision','Location','northeast');
% set(h_legend,'FontSize',15);
% set(gca,'FontSize',20);


% mean_acc_rot = zeros(len_rot,1);
% mean_pre_rot = zeros(len_rot,1);
% for i = 1:len_rot
%     for i_cell = 1:num
%         mean_acc_rot(i) = mean_acc_rot(i)+accuracy_rot{i_cell}(i);
%         mean_pre_rot(i) = mean_pre_rot(i)+precision_rot{i_cell}(i);
%     end
%     mean_acc_rot(i) = mean_acc_rot(i)/(num);
%     mean_pre_rot(i) = mean_pre_rot(i)/(num);
% end
% mean_acc_rot(end) = 0.1;
% plot(theta_rot_list,mean_acc_rot,'LineWidth',2)
% hold on
% plot(theta_rot_list,mean_pre_rot,'LineWidth',2)
% xlabel('sigma\_rot','FontSize',20,'Interpreter','Latex')
% ylabel('recall','FontSize',20,'Interpreter','Latex')
% h_legend=legend('recall','precision','Location','northeast');
% set(h_legend,'FontSize',15);
% set(gca,'FontSize',20);

% % figure(2)
% mean_el = zeros(len_el,1);
% mean_acc_el = zeros(len_el,1);
% mean_pre_el = zeros(len_el,1);
% for i = 1:len_el
%     for i_cell = 1:num
%         mean_el(i) = mean_el(i)+el{i_cell}(i);
%         mean_acc_el(i) = mean_acc_el(i)+accuracy_elong{i_cell}(i);
%         mean_pre_el(i) = mean_pre_el(i)+precision_elong{i_cell}(i);
%     end
%     mean_el(i) = mean_el(i)/num;
%     mean_acc_el(i) = mean_acc_el(i)/num;
%     mean_pre_el(i) = mean_pre_el(i)/num;
% end
% plot(mean_el,mean_acc_el,'LineWidth',2)
% hold on
% plot(mean_el,mean_pre_el,'LineWidth',2)
% xlabel('sigma\_el\_coef','FontSize',20,'Interpreter','Latex')
% ylabel('recall','FontSize',20,'Interpreter','Latex')
% h_legend=legend('recall','precision','Location','northeast');
% set(h_legend,'FontSize',15);
% set(gca,'FontSize',20);