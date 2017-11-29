function [results] = matching_clusters(clusters,coor_1,coor_2,dtheta,num_R,thres_center,thres_score)
len = length(clusters);
similarity_score = cell(len,1);
results = cell(len,1);
cscvn_1 = cell(len,1);
cscvn_2 = cell(len,1);
range_1 = cell(len,1);
range_2 = cell(len,1);
fit_points_shape_1 = cell(len,1);
fit_points_shape_2 = cell(len,1);
for i = 1:len
    disp(i)
%     check size of clusters{i}
    [nrow,~] = size(clusters{i});
    if nrow < 2
        continue;
    end
    ind_1 = find(clusters{i}(:,2)==1);
    ind_2 = find(clusters{i}(:,2)==2);
%     check if any group is empty
    if isempty(ind_1) || isempty(ind_2)
        continue;
    end
    len_1 = length(ind_1);
    len_2 = length(ind_2);
    similarity_score{i} = zeros(len_1,len_2);
    for i_1 = 1:len_1
        for i_2 = 1:len_2
            indiv_1 = clusters{i}(ind_1(i_1),1);
            indiv_2 = clusters{i}(ind_2(i_2),1);
            for ind_indiv_1 = 1:length(coor_1)
                if coor_1{ind_indiv_1}(1,end)==indiv_1
                    break;
                end
            end
            for ind_indiv_2 = 1:length(coor_2)
                if coor_2{ind_indiv_2}(1,end)==indiv_2
                    break;
                end
            end
%             detect close pairs
            if norm(coor_1{ind_indiv_1}(:,1)-coor_2{ind_indiv_2}(:,1))>thres_center
                continue;
            end
%             get similarity score for the pair
            points_shape_1 = coor_1{ind_indiv_1}(:,2:end-1);
            points_shape_2 = coor_2{ind_indiv_2}(:,2:end-1);
            
%             myway
            %     fit cubicspline
            cscvn_1{i} = cscvn(points_shape_1);
            cscvn_2{i} = cscvn(points_shape_2);
            ran_1 = [cscvn_1{i}.breaks(1),cscvn_1{i}.breaks(end)];
            ran_2 = [cscvn_2{i}.breaks(1),cscvn_2{i}.breaks(end)];
            range_1{i} = linspace(ran_1(1),ran_1(2),100);
            range_2{i} = linspace(ran_2(1),ran_2(2),100);
            fit_points_shape_1{i} = fnval(cscvn_1{i},range_1{i});
            fit_points_shape_2{i} = fnval(cscvn_2{i},range_2{i});
    
%     sample uniform grid from fitted points
    
            index_fit_points_shape_1 = 1:1:99;
            index_fit_points_shape_2 = 1:1:99;

%     points to be used to construct feature matrices
            selected_fit_points_shape_1 = fit_points_shape_1{i}(:,index_fit_points_shape_1);
            selected_fit_points_shape_2 = fit_points_shape_2{i}(:,index_fit_points_shape_2);  
            
%             selected_fit_points_shape_1 = interparc(100,points_shape_1(1,:),points_shape_1(2,:),'csape')';
%             selected_fit_points_shape_2 = interparc(100,points_shape_2(1,:),points_shape_2(2,:),'csape')';
            [~,obj_max] = two_shape_matching_intlinprog(selected_fit_points_shape_1,selected_fit_points_shape_2,dtheta,num_R);
            if obj_max > thres_score
                similarity_score{i}(i_1,i_2) = obj_max;
            end
        end
    end
    
%     case 1: group_1 contain 1 neuron
    if len_1==1 && len_2 >=1
        [max_score,ind_score_1] = max(similarity_score{i}(1,1:len_2));
        if max_score > 0
            results{i}(1,1:2) = [clusters{i}(ind_1(1),1),clusters{i}(ind_2(ind_score_1),1)];
            results{i}(1,3) = similarity_score{i}(1,ind_score_1);
        end
        continue;
    end
%     case 2: group_2 contains 1 neuron
    if len_1>=1 && len_2 ==1
        [max_score,ind_score_2] = max(similarity_score{i}(1:len_1,1));
        if max_score > 0
            results{i}(1,1:2) = [clusters{i}(ind_1(ind_score_2),1),clusters{i}(ind_2(1),1)];
            results{i}(1,3) = similarity_score{i}(ind_score_2,1);
        end
        continue;
    end
    
    
    filter = similarity_score{i};
    filter(filter > 0) = 1;
    dim = len_1*len_2;
    similarity_score_tmp_reshape = reshape(similarity_score{i}',[dim,1]);
%     solve integer programming to provide a 1-1 matching
    A = zeros(len_1+len_2,dim);
    for j_1 = 1:len_1
        for j_2 = 1:len_2
            A(j_1,(j_1-1)*len_2+j_2) = 1;
        end
    end
    for j_1 = 1:len_2
        for j_2 = 1:len_1
            A(len_1+j_1,(j_2-1)*len_2+j_1) = 1;
        end
    end
    b = ones(len_1+len_2,1);
    lb = zeros(dim,1);
    ub = ones(dim,1);
    intcon = 1:dim;
    Aeq = [];
    beq = [];
    c = intlinprog(-similarity_score_tmp_reshape,intcon,A,b,Aeq,beq,lb,ub);
%     obj = similarity_score_tmp_reshape'*c;
    c = reshape(c,[len_2,len_1])';
%     filt c
    c = filter.*c;
    
    count_pair = 0;
    for j_1 = 1:len_1
        for j_2 = 1:len_2
            if c(j_1,j_2) == 1
                if similarity_score{i}(j_1,j_2)>0
                    count_pair = count_pair + 1;
                    results{i}(count_pair,1:2) = [clusters{i}(ind_1(j_1),1),clusters{i}(ind_2(j_2),1)];
                    results{i}(count_pair,3) = similarity_score{i}(j_1,j_2);
                end
            end
        end
    end
end
end