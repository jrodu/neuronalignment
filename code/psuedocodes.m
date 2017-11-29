figure(2)
for i = 1:1
    plot(ell_data_2_back{i}(1,2:end-1),ell_data_2_back{i}(2,2:end-1),'r');
    hold on
    plot(ell_data{i}(1,2:end-1),ell_data{i}(2,2:end-1),'b');
%     text(ell_data_2_back{i}(1,1),ell_data_2_back{i}(2,1),num2str(ell_data_2_back{i}(1,end)));
end