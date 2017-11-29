% input allData of 11 datasets
allData_copy = allData;
num_mouse = 11;
for num = 1:num_mouse
    len_match = length(allData(num).index);
    for i = 1:len_match
        tmp_index = allData(num).index;
        allData_copy(num).skfData(i) = allData(num).skfData(tmp_index(i,2));
        allData_copy(num).salData(i) = allData(num).salData(tmp_index(i,1));
    end
    i_skf = len_match+1;
    i_sal = len_match+1;
    for i = 1:length(allData(num).skfData)
        tmp_index = allData(num).index;
        if ~ismember(i,tmp_index(:,2))
            allData_copy(num).skfData(i_skf) = allData(num).skfData(i);
            i_skf = i_skf+1;
        end
    end
    for i = 1:length(allData(num).salData)
        tmp_index = allData(num).index;
        if ~ismember(i,tmp_index(:,1))
            allData_copy(num).salData(i_sal) = allData(num).salData(i);
            i_sal = i_sal+1;
        end
    end
end

remove_cell = cell(11,1);
remove_cell{1} = struct('skf',[93,96,100,101,109,110,112],'sal',[]);
remove_cell{2} = struct('skf',[58],'sal',[58]);
remove_cell{3} = struct('skf',[61,62,65,66],'sal',[30]);
remove_cell{4} = struct('skf',[89,98],'sal',[87,98,99]);
remove_cell{5} = struct('skf',[],'sal',[67]);
remove_cell{6} = struct('skf',[52],'sal',[]);
remove_cell{7} = struct('skf',[],'sal',[]);
remove_cell{8} = struct('skf',[],'sal',[]);
remove_cell{9} = struct('skf',[],'sal',[]);
remove_cell{10} = struct('skf',[],'sal',[]);
remove_cell{11} = struct('skf',[],'sal',[]);

for i = 1:11
    allData_copy(i).skfData(remove_cell{i}.skf) = [];
    allData_copy(i).salData(remove_cell{i}.sal) = [];
end

% % get the mean of close neuron centers
% tot = 86;
% points_sky = cell(tot,1);
% points_sal = cell(tot,1);
% for t = 1:tot
%     points_sky{t} = [allData_copy(8).skfData(t).x;allData_copy(8).skfData(t).y];
%     points_sal{t} = [allData_copy(8).salData(t).x;allData_copy(8).salData(t).y];
% end
% ave_dist_sky = avgcdist(points_sky);
% ave_dist_sal = avgcdist(points_sal);
% sum_dist = 0;
% for t = 1:tot
%     sum_dist = sum_dist+norm(ell_data{t}(:,1)-ell_data_2_back{t}(:,1));
% end
% mean_dist = sum_dist/tot;