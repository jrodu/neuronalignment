len_1 = length(neuron_1.Coor);
len_2 = length(neuron_2.Coor);
ell_data = cell(len_1+4,1);
ell_data_2 = cell(len_2+4,1);
Rot = [0.6753,0.7290;-0.7517,0.6797];
trans = [153.7082,-83.9849];

for i = 1:len_1
    [~,len_neuron] = size(neuron_1.Coor{i});
    ell_data{i} = zeros(2,len_neuron+3);
    ell_data{i}(:,2:len_neuron+1) = neuron_1.Coor{i};
    ell_data{i}(:,len_neuron+2) = neuron_1.Coor{i}(:,1);
    ell_data{i}(:,1) = [mean(ell_data{i}(1,2:len_neuron+2)),mean(ell_data{i}(2,2:len_neuron+2))];
    ell_data{i}(1,len_neuron+3) = i;
end


for i = 1:len_2
    [~,len_neuron] = size(neuron_2.Coor{i});
    ell_data_2{i} = zeros(2,len_neuron+3);
    ell_data_2{i}(:,2:len_neuron+1) = neuron_2.Coor{i};
    ell_data_2{i}(:,len_neuron+2) = neuron_2.Coor{i}(:,1);
    ell_data_2{i}(:,1) = [mean(ell_data_2{i}(1,2:len_neuron+2)),mean(ell_data_2{i}(2,2:len_neuron+2))];
    ell_data_2{i}(1,len_neuron+3) = i;
end


ell_data_2{len_2+1} = ell_data_2{11};
ell_data_2{len_2+1}(:,2:end-1) = ell_data_2{len_2+1}(:,2:end-1)+0.1*randn(2,length(ell_data_2{len_2+1}(1,:))-2)+[30;0];
ell_data_2{len_2+1}(:,end-1) = ell_data_2{len_2+1}(:,2);
ell_data_2{len_2+1}(:,1) = mean(ell_data_2{len_2+1}(:,2:end-1),2);
ell_data_2{len_2+1}(:,end) = [len_2+1;0];

ell_data_2{len_2+2} = ell_data_2{2};
ell_data_2{len_2+2}(:,2:end-1) = ell_data_2{len_2+2}(:,2:end-1)+0.1*randn(2,length(ell_data_2{len_2+2}(1,:))-2)+[20;-20];
ell_data_2{len_2+2}(:,end-1) = ell_data_2{len_2+2}(:,2);
ell_data_2{len_2+2}(:,1) = mean(ell_data_2{len_2+2}(:,2:end-1),2);
ell_data_2{len_2+2}(:,end) = [len_2+2;0];

ell_data_2{len_2+3} = ell_data_2{10};
ell_data_2{len_2+3}(:,2:end-1) = ell_data_2{len_2+3}(:,2:end-1)+0.1*randn(2,length(ell_data_2{len_2+3}(1,:))-2)+[-20;10];
ell_data_2{len_2+3}(:,end-1) = ell_data_2{len_2+3}(:,2);
ell_data_2{len_2+3}(:,1) = mean(ell_data_2{len_2+3}(:,2:end-1),2);
ell_data_2{len_2+3}(:,end) = [len_2+3;0];

ell_data_2{len_2+4} = ell_data_2{5};
ell_data_2{len_2+4}(:,2:end-1) = ell_data_2{len_2+4}(:,2:end-1)+0.1*randn(2,length(ell_data_2{len_2+4}(1,:))-2)+[20;-20];
ell_data_2{len_2+4}(:,end-1) = ell_data_2{len_2+4}(:,2);
ell_data_2{len_2+4}(:,1) = mean(ell_data_2{len_2+4}(:,2:end-1),2);
ell_data_2{len_2+4}(:,end) = [len_2+4;0];



for i = 1:4
    [~,n] = size(ell_data_2{len_2+i});
    n = n-2;
    ell_data{len_1+i} = zeros(2,n+2);
    ell_data{len_1+i}(:,1:n+1) = Rot'*ell_data_2{len_2+i}(:,1:n+1) + trans'*ones(1,n+1)+[1;1]*randn*1;
    ell_data{len_1+i}(:,end) = [len_1+i;0];
end



% figure(1);
% for i = 1:len_1+4
%     plot(ell_data{i}(1,2:end-1),ell_data{i}(2,2:end-1));
%     hold on
%     text(ell_data{i}(1,1),ell_data{i}(2,1),num2str(ell_data{i}(1,end)));
% end
% 
% figure(2);
% for i = 1:len_2+4
%     plot(ell_data_2{i}(1,2:end-1),ell_data_2{i}(2,2:end-1));
%     hold on
%     text(ell_data_2{i}(1,1),ell_data_2{i}(2,1),num2str(ell_data_2{i}(1,end)));
% end
