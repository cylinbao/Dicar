clear all;

%result = load('./nuSVModel_001_n.mat');
%result_mtx(1,1) = result.acc(1);

result = load('./nuSVModel_01_n.mat');
result_mtx(1,1) = result.acc(1);

result = load('./nuSVModel_05_n.mat');
result_mtx(2,1) = result.acc(1);

result = load('./nuSVModel_1_n.mat');
result_mtx(3,1) = result.acc(1);
