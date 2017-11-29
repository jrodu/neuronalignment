function [ results ] = matching_SSE(clusters,coor_1,coor_2,thres_center,grid_theta,w_shape,w_dist,thres_simi_score)
len = length(clusters);
similarity_score = cell(len,1);
results = cell(len,1);
for i = 1:len
%     disp(i)
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
    similarity_score{i} = Inf*ones(len_1,len_2);
    for i_1 = 1:len_1
        for i_2 = 1:len_2
%             disp('i1')
%             disp(i_1)
%             disp('i2')
%             disp(i_2)
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
            
            [~,size_1] = size(points_shape_1);
            [~,size_2] = size(points_shape_2);
            
            centered_points_1 = points_shape_1 - repmat(coor_1{ind_indiv_1}(:,1),1,size_1);
            centered_points_2 = points_shape_2 - repmat(coor_2{ind_indiv_2}(:,1),1,size_2);
%             if i==5
%                 disp(size(centered_points_1))
%                 disp(size(centered_points_2))
%             end
            
            coor_1_final = polar_coor(centered_points_1,grid_theta);
            coor_2_final = polar_coor(centered_points_2,grid_theta);
            coor_1_final = cell2mat(coor_1_final);
            coor_2_final = cell2mat(coor_2_final);
            
            if size(coor_1_final) == size(coor_2_final)
                score_shape = mean(sqrt(sum((coor_1_final-coor_2_final).^2,2)));
                score_center_dist = norm(coor_1{ind_indiv_1}(:,1) - coor_2{ind_indiv_2}(:,1));
            
                score = score_shape*w_shape + score_center_dist*w_dist;

                similarity_score{i}(i_1,i_2) = score;
            end
            
%             disp(size(coor_1_final))
%             disp(size(coor_2_final))
%            
%             
            
        end
    end
    
%     case 1: group_1 contain 1 neuron
    if len_1==1 && len_2 >=1
        [min_score,ind_score_1] = min(similarity_score{i}(1,1:len_2));
        if min_score > 0 && min_score < thres_simi_score
            results{i}(1,1:2) = [clusters{i}(ind_1(1),1),clusters{i}(ind_2(ind_score_1),1)];
            results{i}(1,3) = similarity_score{i}(1,ind_score_1);
        end
        continue;
    end
%     case 2: group_2 contains 1 neuron
    if len_1>=1 && len_2 ==1
        [min_score,ind_score_2] = min(similarity_score{i}(1:len_1,1));
        if min_score > 0 && min_score < thres_simi_score
            results{i}(1,1:2) = [clusters{i}(ind_1(ind_score_2),1),clusters{i}(ind_2(1),1)];
            results{i}(1,3) = similarity_score{i}(ind_score_2,1);
        end
        continue;
    end
    
    filter = similarity_score{i};
    Ind_h = find(filter>thres_simi_score);
    Ind_l = find(filter<=thres_simi_score);
    filter(Ind_h) = 0;
    filter(Ind_l) = 1;
    disp(sum(sum(filter)))
    
    dim = len_1*len_2;
    similarity_score_tmp_reshape = reshape(similarity_score{i}',[dim,1]);
    notInfindex = find(~isinf(similarity_score_tmp_reshape));
    max_value = max(similarity_score_tmp_reshape(notInfindex));
    for ind_score = 1:length(similarity_score_tmp_reshape)
        if isinf(similarity_score_tmp_reshape(ind_score))
            similarity_score_tmp_reshape(ind_score)=0;
        else
            similarity_score_tmp_reshape(ind_score)=-similarity_score_tmp_reshape(ind_score)+max_value;
        end
    end
    
    
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
    
%     if len_1 <= len_2
%         Aeq = zeros(len_1,dim);
%         beq = ones(len_1,1);
%         for j_1 = 1:len_1
%             for j_2 = 1:len_2
%                 Aeq(j_1,(j_1-1)*len_2+j_2) = 1;
%             end
%         end
%     else
%         Aeq = zeros(len_2,dim);
%         beq = ones(len_2,1);
%         for j_1 = 1:len_2
%             for j_2 = 1:len_1
%                 Aeq(j_1,(j_2-1)*len_2+j_1) = 1;
%             end
%         end
%     end
    b = ones(len_1+len_2,1);
    lb = zeros(dim,1);
    ub = ones(dim,1);
    intcon = 1:dim;
%     disp(max(abs(similarity_score_tmp_reshape)))
    c = intlinprog(-similarity_score_tmp_reshape,intcon,A,b,[],[],lb,ub);
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