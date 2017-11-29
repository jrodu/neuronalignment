
index = 2;
mouse_skf = allData_copy(index).skfData;
[~,size_skf] = size(allData_copy(index).skfData);
mouse_skf_coor = cell(size_skf,1);
for i = 1:size_skf
    if 1
        mouse_skf_coor{i} = mouse_skf(i).contour;
    end   
end
empty = cellfun('isempty',mouse_skf_coor);
mouse_skf_coor(empty)=[];
mouse_sal = allData_copy(index).salData;
[~,size_sal] = size(allData_copy(index).salData);
mouse_sal_coor = cell(size_sal,1);
for i = 1:size_sal
    mouse_sal_coor{i} = mouse_sal(i).contour;
end

% len_1 = length(neuron_1.Coor);
% len_2 = length(neuron_2.Coor);
len_1 = length(mouse_skf_coor);
len_2 = length(mouse_sal_coor);

ell_data = cell(len_1,1);
ell_data_2 = cell(len_2,1);
thres_simi_score = 3;
thres_center = 8;
w_dist = 0.3;
w_shape = 0.7;
thres_reg = 0.3;

for i = 1:len_1
    [~,len_neuron] = size(mouse_skf_coor{i});
    ell_data{i} = zeros(2,len_neuron+2);
    ell_data{i}(:,2:len_neuron+1) = mouse_skf_coor{i};
    ell_data{i}(:,1) = [mean(ell_data{i}(1,2:len_neuron+1)),mean(ell_data{i}(2,2:len_neuron+1))];
    ell_data{i}(1,len_neuron+2) = i;
end

for i = 1:len_2
    [~,len_neuron] = size(mouse_sal_coor{i});
    ell_data_2{i} = zeros(2,len_neuron+2);
    ell_data_2{i}(:,2:len_neuron+1) = mouse_sal_coor{i};
    ell_data_2{i}(:,1) = [mean(ell_data_2{i}(1,2:len_neuron+1)),mean(ell_data_2{i}(2,2:len_neuron+1))];
    ell_data_2{i}(1,len_neuron+2) = i;
end

% for i = 1:len_1
%     [~,len_neuron] = size(neuron_1.Coor{i});
%     ell_data{i} = zeros(2,len_neuron+3);
%     ell_data{i}(:,2:len_neuron+1) = neuron_1.Coor{i};
%     ell_data{i}(:,len_neuron+2) = neuron_1.Coor{i}(:,1);
%     ell_data{i}(:,1) = [mean(ell_data{i}(1,2:len_neuron+2)),mean(ell_data{i}(2,2:len_neuron+2))];
%     ell_data{i}(1,len_neuron+3) = i;
% end
% 
% for i = 1:len_2
%     [~,len_neuron] = size(neuron_2.Coor{i});
%     ell_data_2{i} = zeros(2,len_neuron+3);
%     ell_data_2{i}(:,2:len_neuron+1) = neuron_2.Coor{i};
%     ell_data_2{i}(:,len_neuron+2) = neuron_2.Coor{i}(:,1);
%     ell_data_2{i}(:,1) = [mean(ell_data_2{i}(1,2:len_neuron+2)),mean(ell_data_2{i}(2,2:len_neuron+2))];
%     ell_data_2{i}(1,len_neuron+3) = i;
% end


test_clusters;



% figure(1);
% for i = 1:len_1
%     plot(ell_data{i}(1,2:end-1),ell_data{i}(2,2:end-1),'LineWidth',2,'Color','k');
%     hold on
%     text(ell_data{i}(1,1),ell_data{i}(2,1),num2str(ell_data{i}(1,end)));
% end
% % customized
% plot(ell_data{18}(1,2:end-1),ell_data{18}(2,2:end-1),'LineWidth',2,'Color',[1,0,0]);
% hold on
% plot(ell_data{5}(1,2:end-1),ell_data{5}(2,2:end-1),'LineWidth',2,'Color',[1,0,0]);
% hold on
% plot(ell_data{14}(1,2:end-1),ell_data{14}(2,2:end-1),'LineWidth',2,'Color',[1,0,0]);
% hold on
% plot(ell_data{12}(1,2:end-1),ell_data{12}(2,2:end-1),'LineWidth',2,'Color',[1,0,0]);
% hold on
% plot(ell_data{3}(1,2:end-1),ell_data{3}(2,2:end-1),'LineWidth',2,'Color',[1,0,0]);
% hold on
% plot(ell_data{4}(1,2:end-1),ell_data{4}(2,2:end-1),'LineWidth',2,'Color','g');
% hold on
% plot(ell_data{10}(1,2:end-1),ell_data{10}(2,2:end-1),'LineWidth',2,'Color','g');
% hold on
% plot(ell_data{6}(1,2:end-1),ell_data{6}(2,2:end-1),'LineWidth',2,'Color','b');
% hold on
% plot(ell_data{21}(1,2:end-1),ell_data{21}(2,2:end-1),'LineWidth',2,'Color','b');
% 
% xlabel('','FontSize',20,'Interpreter','Latex')
% ylabel('','FontSize',20,'Interpreter','Latex')
% set(gca,'FontSize',20);
% 
% figure(2);
% for i = 1:len_2
%     plot(ell_data_2{i}(1,2:end-1),ell_data_2{i}(2,2:end-1),'LineWidth',2,'Color','k');
%     hold on
%     text(ell_data_2{i}(1,1),ell_data_2{i}(2,1),num2str(ell_data_2{i}(1,end)));
% end
% plot(ell_data_2{5}(1,2:end-1),ell_data_2{5}(2,2:end-1),'LineWidth',2,'Color',[1,0,0]);
% hold on
% plot(ell_data_2{3}(1,2:end-1),ell_data_2{3}(2,2:end-1),'LineWidth',2,'Color',[1,0,0]);
% hold on
% plot(ell_data_2{6}(1,2:end-1),ell_data_2{6}(2,2:end-1),'LineWidth',2,'Color',[1,0,0]);
% hold on
% plot(ell_data_2{10}(1,2:end-1),ell_data_2{10}(2,2:end-1),'LineWidth',2,'Color',[1,0,0]);
% hold on
% plot(ell_data_2{2}(1,2:end-1),ell_data_2{2}(2,2:end-1),'LineWidth',2,'Color',[1,0,0]);
% hold on
% plot(ell_data_2{9}(1,2:end-1),ell_data_2{9}(2,2:end-1),'LineWidth',2,'Color','g');
% hold on
% plot(ell_data_2{4}(1,2:end-1),ell_data_2{4}(2,2:end-1),'LineWidth',2,'Color','g');
% hold on
% plot(ell_data_2{1}(1,2:end-1),ell_data_2{1}(2,2:end-1),'LineWidth',2,'Color','b');
% hold on
% plot(ell_data_2{11}(1,2:end-1),ell_data_2{11}(2,2:end-1),'LineWidth',2,'Color','b');
% xlabel('','FontSize',20,'Interpreter','Latex')
% ylabel('','FontSize',20,'Interpreter','Latex')
% set(gca,'FontSize',20);
% 
% figure(3);
% for i = 1:len_2
%     plot(ell_data_2_back{i}(1,2:end-1),ell_data_2_back{i}(2,2:end-1),'LineWidth',2,'Color','k');
%     hold on
%     text(ell_data_2_back{i}(1,1),ell_data_2_back{i}(2,1),num2str(ell_data_2_back{i}(1,end)));
% end
% plot(ell_data_2_back{5}(1,2:end-1),ell_data_2_back{5}(2,2:end-1),'LineWidth',2,'Color',[1,0,0]);
% hold on
% plot(ell_data_2_back{3}(1,2:end-1),ell_data_2_back{3}(2,2:end-1),'LineWidth',2,'Color',[1,0,0]);
% hold on
% plot(ell_data_2_back{6}(1,2:end-1),ell_data_2_back{6}(2,2:end-1),'LineWidth',2,'Color',[1,0,0]);
% hold on
% plot(ell_data_2_back{10}(1,2:end-1),ell_data_2_back{10}(2,2:end-1),'LineWidth',2,'Color',[1,0,0]);
% hold on
% plot(ell_data_2_back{2}(1,2:end-1),ell_data_2_back{2}(2,2:end-1),'LineWidth',2,'Color',[1,0,0]);
% hold on
% plot(ell_data_2_back{9}(1,2:end-1),ell_data_2_back{9}(2,2:end-1),'LineWidth',2,'Color','g');
% hold on
% plot(ell_data_2_back{4}(1,2:end-1),ell_data_2_back{4}(2,2:end-1),'LineWidth',2,'Color','g');
% hold on
% plot(ell_data_2_back{1}(1,2:end-1),ell_data_2_back{1}(2,2:end-1),'LineWidth',2,'Color','b');
% hold on
% plot(ell_data_2_back{11}(1,2:end-1),ell_data_2_back{11}(2,2:end-1),'LineWidth',2,'Color','b');
% xlabel('','FontSize',20,'Interpreter','Latex')
% ylabel('','FontSize',20,'Interpreter','Latex')
% set(gca,'FontSize',20);


correct = 0;
% 1-dim
true_find = [];
% 1-dim true-lost
% 2-dim
false_find = [];
for i = 1:length(matching_results_adj_matrix)
    match_1 = matching_results_adj_matrix(i,1);
    match_2 = matching_results_adj_matrix(i,2);
    if match_1 == match_2 && match_1 <= length(allData(index).index)
        correct = correct+1;
        true_find = [true_find;match_1];
    end
end

true_lost = setdiff(1:length(allData(index).index),true_find)';

false_lost_skf = length(allData(index).index)+1:length(allData(index).skfData);
false_lost_sal = length(allData(index).index)+1:length(allData(index).salData);

precision = correct/length(matching_results_adj_matrix);
recall = correct/length(allData(index).index);

figure(1)
for i = 1:len_1
    if ismember(i,true_find)
        plot(ell_data{i}(1,2:end-1),ell_data{i}(2,2:end-1),'LineWidth',2,'Color','r');
        hold on
        text(ell_data{i}(1,1),ell_data{i}(2,1),num2str(ell_data{i}(1,end)));
    elseif ismember(i,true_lost)
        plot(ell_data{i}(1,2:end-1),ell_data{i}(2,2:end-1),'LineWidth',2,'Color','b');
        hold on
        text(ell_data{i}(1,1),ell_data{i}(2,1),num2str(ell_data{i}(1,end)));
    else
        plot(ell_data{i}(1,2:end-1),ell_data{i}(2,2:end-1),'LineWidth',2,'Color','k');
        hold on
        text(ell_data{i}(1,1),ell_data{i}(2,1),num2str(ell_data{i}(1,end)));
    end
    
end


figure(2)
for i = 1:len_2
    if ismember(i,true_find)
        plot(ell_data_2{i}(1,2:end-1),ell_data_2{i}(2,2:end-1),'LineWidth',2,'Color','r');
        hold on
        text(ell_data_2{i}(1,1),ell_data_2{i}(2,1),num2str(ell_data_2{i}(1,end)));
    elseif ismember(i,true_lost)
        plot(ell_data_2{i}(1,2:end-1),ell_data_2{i}(2,2:end-1),'LineWidth',2,'Color','b');
        hold on
        text(ell_data_2{i}(1,1),ell_data_2{i}(2,1),num2str(ell_data_2{i}(1,end)));
    else
        plot(ell_data_2{i}(1,2:end-1),ell_data_2{i}(2,2:end-1),'LineWidth',2,'Color','k');
        hold on
        text(ell_data_2{i}(1,1),ell_data_2{i}(2,1),num2str(ell_data_2{i}(1,end)));
    end
    
end


figure(3)
for i = 1:len_2
    if ismember(i,true_find)
        plot(ell_data_2_back{i}(1,2:end-1),ell_data_2_back{i}(2,2:end-1),'LineWidth',2,'Color','r');
        hold on
        text(ell_data_2_back{i}(1,1),ell_data_2_back{i}(2,1),num2str(ell_data_2_back{i}(1,end)));
    elseif ismember(i,true_lost)
        plot(ell_data_2_back{i}(1,2:end-1),ell_data_2_back{i}(2,2:end-1),'LineWidth',2,'Color','b');
        hold on
        text(ell_data_2_back{i}(1,1),ell_data_2_back{i}(2,1),num2str(ell_data_2_back{i}(1,end)));
    else
        plot(ell_data_2_back{i}(1,2:end-1),ell_data_2_back{i}(2,2:end-1),'LineWidth',2,'Color','k');
        hold on
        text(ell_data_2_back{i}(1,1),ell_data_2_back{i}(2,1),num2str(ell_data_2_back{i}(1,end)));
    end
    
end


% figure(4)
% i=98;
% plot(ell_data{i}(1,2:end-1),ell_data{i}(2,2:end-1),'LineWidth',2,'Color','b');
% hold on
% text(ell_data{i}(1,1),ell_data{i}(2,1),num2str(ell_data{i}(1,end)));
% xlim([50,350])
% ylim([0,250])

% len_sky = size_sky;
% len_sal = size_sal;
% len_match = length(matching_results_adj_matrix);
% 
% figure(1)
% m = 1;
% for i = 1:len_1
%     if ~ismember(i,matching_results_adj_matrix(:,1))
%         plot(ell_data{i}(1,2:end-1),ell_data{i}(2,2:end-1),'LineWidth',2,'Color','k');
%         hold on
%         text(ell_data{i}(1,1),ell_data{i}(2,1),num2str(len_match+m));
%         m=m+1;
%     end
%     
% end
% 
% 
% figure(2)
% m=1;
% for i = 1:len_2
%     if ~ismember(i,matching_results_adj_matrix(:,2))
%         plot(ell_data_2{i}(1,2:end-1),ell_data_2{i}(2,2:end-1),'LineWidth',2,'Color','k');
%         hold on
%         text(ell_data_2{i}(1,1),ell_data_2{i}(2,1),num2str(len_match+m));
%         m=m+1;
%     end
%     
% end
% 
% 
% figure(3)
% cor=1;
% m=1;
% for i = 1:len_2
%     if ~ismember(i,matching_results_adj_matrix(:,2))
%         plot(ell_data_2_back{i}(1,2:end-1),ell_data_2_back{i}(2,2:end-1),'LineWidth',2,'Color','k');
%         hold on
%         text(ell_data_2_back{i}(1,1),ell_data_2_back{i}(2,1),num2str(len_match+m));
%         m=m+1;
%     end
%     
% end
% 
% for i = 1:len_match
%     figure(1)
%     if ismember(i,true_find)
%         plot(ell_data{i}(1,2:end-1),ell_data{i}(2,2:end-1),'LineWidth',2,'Color','r');
%         hold on
%         text(ell_data{i}(1,1),ell_data{i}(2,1),num2str(ell_data{i}(1,end)));
%     elseif ismember(i,matching_results_adj_matrix(:,1))
%         plot(ell_data{i}(1,2:end-1),ell_data{i}(2,2:end-1),'LineWidth',2,'Color','g');
%         hold on
%         text(ell_data{i}(1,1),ell_data{i}(2,1),num2str(ell_data{i}(1,end)));
%     end
%     
%     figure(2)
%     if ismember(i,true_find)
%         plot(ell_data_2{i}(1,2:end-1),ell_data_2{i}(2,2:end-1),'LineWidth',2,'Color','r');
%         hold on
%         text(ell_data_2{i}(1,1),ell_data_2{i}(2,1),num2str(ell_data_2{i}(1,end)));
%     elseif ismember(i,matching_results_adj_matrix(:,2))
%         plot(ell_data_2{i}(1,2:end-1),ell_data_2{i}(2,2:end-1),'LineWidth',2,'Color','g');
%         hold on
%         text(ell_data_2{i}(1,1),ell_data_2{i}(2,1),num2str(ell_data_2{i}(1,end)));
%     end
%     
%     figure(3)
%     if ismember(i,true_find)
%         plot(ell_data_2_back{i}(1,2:end-1),ell_data_2_back{i}(2,2:end-1),'LineWidth',2,'Color','r');
%         hold on
%         text(ell_data_2_back{i}(1,1),ell_data_2_back{i}(2,1),num2str(ell_data_2_back{i}(1,end)));
%     elseif ismember(i,matching_results_adj_matrix(:,2))
%         plot(ell_data_2_back{i}(1,2:end-1),ell_data_2_back{i}(2,2:end-1),'LineWidth',2,'Color','g');
%         hold on
%         text(ell_data_2_back{i}(1,1),ell_data_2_back{i}(2,1),num2str(ell_data_2_back{i}(1,end)));
%     end
%     
% end