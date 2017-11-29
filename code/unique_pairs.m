function [uniqued_pairs,k] = unique_pairs(pairs)
seq_1 = [];
seq_2 = [];
[dim,~] = size(pairs);
for i = 1:dim
    if any(pairs(i,1)==seq_1) || any(pairs(i,2)==seq_2)
        continue;
    else
        seq_1 = [seq_1;pairs(i,1)];
        seq_2 = [seq_2;pairs(i,2)];
    end
end
uniqued_pairs = [seq_1,seq_2];
[k,~] = size(uniqued_pairs);
end