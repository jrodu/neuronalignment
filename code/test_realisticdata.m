gen_realisticdata;
thres_center = 20;
test_clusters;

figure(1);
for i = 1:len_1+4
    plot(ell_data{i}(1,2:end-1),ell_data{i}(2,2:end-1));
    hold on
    text(ell_data{i}(1,1),ell_data{i}(2,1),num2str(ell_data{i}(1,end)));
end

figure(2);
for i = 1:len_2+4
    plot(ell_data_2{i}(1,2:end-1),ell_data_2{i}(2,2:end-1));
    hold on
    text(ell_data_2{i}(1,1),ell_data_2{i}(2,1),num2str(ell_data_2{i}(1,end)));
end

figure(3);
for i = 1:len_2+4
    plot(ell_data_2_back{i}(1,2:end-1),ell_data_2_back{i}(2,2:end-1));
    hold on
    text(ell_data_2_back{i}(1,1),ell_data_2_back{i}(2,1),num2str(ell_data_2_back{i}(1,end)));
end
