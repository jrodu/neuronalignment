a_1 = 14;
a_2 = 14;
tex = 40;

figure
plot(ell_data{a_1}(1,2:end-1),ell_data{a_1}(2,2:end-1),'Color','b')

% for i = 1:100
%     text(selected_fit_points_shape_1{tex}(1,i),selected_fit_points_shape_1{tex}(2,i),num2str(i))
% end
hold on
plot(ell_data_2_back{a_2}(1,2:end-1),ell_data_2_back{a_2}(2,2:end-1),'Color','r')
% for i = 1:100
%     text(selected_fit_points_shape_2{tex}(1,i),selected_fit_points_shape_2{tex}(2,i),num2str(i))
% end
% hold on
% plot(ell_data_2_back{57}(1,2:end-1),ell_data_2_back{57}(2,2:end-1),'k')
% for i = 1:297
%     text(fit_points_shape_1(1,i),fit_points_shape_1(2,i),num2str(i))
% end