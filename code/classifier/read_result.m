clear all;

result = load('./nuSVModel_05.mat');
result_mtx(1,1) = result.acc(1);

result = load('./nuSVModel_1.mat');
result_mtx(2,1) = result.acc(1);

result = load('./nuSVModel_2.mat');
result_mtx(3,1) = result.acc(1);

result = load('./nuSVModel_25.mat');
result_mtx(4,1) = result.acc(1);

result = load('./nuSVModel_4.mat');
result_mtx(5,1) = result.acc(1);

result = load('./nuSVModel_5.mat');
result_mtx(6,1) = result.acc(1);
