test_drop = [0,10,20,30,40,50];
test_noise_centers = [0,0.003,0.006,0.009,0.0102,0.0105,0.0108,0.0201];
% test_noise_shape = [0.1,0.15,0.2,0.25,0.3];
test_thres_center = [0.01,0.05,0.09,0.13,0.17];
test_thres_score = [99,96,93,90,87];

results_drop = zeros(6,1);
results_noise_centers = zeros(8,1);
% results_noise_shape = zeros(5,1);
results_thres_center = zeros(5,1);
results_thres_score = zeros(5,1);

for i_test = 1:5
    parameters;
    thres_score = test_thres_score(i_test);
    count = zeros(5,1);
    for i_repeat = 1:5
        test_clusters;
        len = length(matching_results_adj);
        for i_len = 1:len
            [nrow,~] = size(matching_results_adj{i_len});
            for i_row = 1:nrow
                if matching_results_adj{i_len}(i_row,1)==matching_results_adj{i_len}(i_row,2)
                    count(i_repeat) = count(i_repeat)+1;
                end
            end
        end
    end
    results_thres_score(i_test) = mean(count);
end