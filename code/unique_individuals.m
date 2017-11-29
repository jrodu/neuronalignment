function [individuals,len_unique_seq_1,len_unique_seq_2] = unique_individuals(pairs)
seq_1 = pairs(:,1);
seq_2 = pairs(:,2);
unique_seq_1 = unique(seq_1);
unique_seq_2 = unique(seq_2);
len_unique_seq_1 = length(unique_seq_1);
len_unique_seq_2 = length(unique_seq_2);
% individuals_1 = [unique_seq_1,zeros(len_unique_seq_1,1)];
% individuals_2 = [unique_seq_2,zeros(len_unique_seq_2,1)];
% individuals = [individuals_1;individuals_2];
individuals = [unique_seq_1;unique_seq_2];
end