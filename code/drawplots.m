% % adjust for prop\_overlap
% precision = precision_list(:,2,2,1);
% recall = recall_list(:,2,2,1);
% n_drop_list = 0:2:12;
% plot(1-n_drop_list/30,precision,'LineWidth',2)
% hold on
% plot(1-n_drop_list/30,recall,'LineWidth',2)
% ylim([0,1]);
% xlabel('prop\_overlap','FontSize',20,'Interpreter','Latex')
% ylabel('recall or precision','FontSize',20,'Interpreter','Latex')
% h_legend=legend('recall','precision');
% set(h_legend,'FontSize',15);
% set(gca,'FontSize',20);

% % adjust for prop\_pos
% precision = precision_list(3,:,2,3);
% % precision(4) = 0.35;
% recall = recall_list(3,:,2,3);
% % recall(4) = 0.1;
% plot(pos_prop(3,:,2,3),precision,'LineWidth',2)
% hold on
% plot(pos_prop(3,:,2,3),recall,'LineWidth',2)
% xlabel('prop\_pos','FontSize',20,'Interpreter','Latex')
% ylabel('recall or precision','FontSize',20,'Interpreter','Latex')
% h_legend=legend('recall','precision');
% set(h_legend,'FontSize',15);
% set(gca,'FontSize',20);

% % adjust for mu\_rot
% precision = zeros(5,1);
% recall = zeros(5,1);
% for i = 1:5
%     precision(i) = precision_list(3,3,i,3);
%     recall(i) = recall_list(3,3,i,3);
% end
% rot_list = 0:pi/24:pi/6;
% plot(rot_list,precision,'LineWidth',2)
% hold on
% plot(rot_list,recall,'LineWidth',2)
% ylim([0,1])
% xlabel('$\mu_{rot}$','FontSize',20,'Interpreter','Latex')
% ylabel('recall or precision','FontSize',20,'Interpreter','Latex')
% h_legend=legend('recall','precision');
% set(h_legend,'FontSize',15);
% set(gca,'FontSize',20);

% adjust for mu\_elong
precision = zeros(5,1);
recall = zeros(5,1);
for i = 1:5
    precision(i) = precision_list(3,5,1,i);
    recall(i) = recall_list(3,5,1,i);
end
el_list = 1:0.05:1.2;
plot(el_list,precision,'LineWidth',2)
hold on
plot(el_list,recall,'LineWidth',2)
ylim([0,1])
xlabel('$\mu_{elong}$','FontSize',20,'Interpreter','Latex')
ylabel('recall or precision','FontSize',20,'Interpreter','Latex')
h_legend=legend('recall','precision');
set(h_legend,'FontSize',15);
set(gca,'FontSize',20);