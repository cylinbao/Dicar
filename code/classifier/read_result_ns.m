clear all;

% read result from each type of models
result = load('./nuSVModel_001_ns.mat');
result_mtx(1,1) = result.acc(1);
result = load('./nuSVModel_01_ns.mat');
result_mtx(2,1) = result.acc(1);
result = load('./nuSVModel_05_ns.mat');
result_mtx(3,1) = result.acc(1);
result = load('./nuSVModel_1_ns.mat');
result_mtx(4,1) = result.acc(1);

result = load('./nuSVModel_001_nsl.mat');
result_mtx(1,2) = result.acc(1);
result = load('./nuSVModel_01_nsl.mat');
result_mtx(2,2) = result.acc(1);
result = load('./nuSVModel_05_nsl.mat');
result_mtx(3,2) = result.acc(1);
result = load('./nuSVModel_1_nsl.mat');
result_mtx(4,2) = result.acc(1);
result = load('./nuSVModel_25_nsl.mat');
result_mtx(5,2) = result.acc(1);

result = load('./nuSVModel_001_nsp2.mat');
result_mtx(1,3) = result.acc(1);
result = load('./nuSVModel_01_nsp2.mat');
result_mtx(2,3) = result.acc(1);
result = load('./nuSVModel_05_nsp2.mat');
result_mtx(3,3) = result.acc(1);
result = load('./nuSVModel_1_nsp2.mat');
result_mtx(4,3) = result.acc(1);
result = load('./nuSVModel_25_nsp2.mat');
result_mtx(5,3) = result.acc(1);

result = load('./nuSVModel_001_nsp3.mat');
result_mtx(1,4) = result.acc(1);
result = load('./nuSVModel_01_nsp3.mat');
result_mtx(2,4) = result.acc(1);
result = load('./nuSVModel_05_nsp3.mat');
result_mtx(3,4) = result.acc(1);
result = load('./nuSVModel_1_nsp3.mat');
result_mtx(4,4) = result.acc(1);
result = load('./nuSVModel_25_nsp3.mat');
result_mtx(5,4) = result.acc(1);

result = load('./nuSVModel_001_nsp4.mat');
result_mtx(1,5) = result.acc(1);
result = load('./nuSVModel_01_nsp4.mat');
result_mtx(2,5) = result.acc(1);
result = load('./nuSVModel_05_nsp4.mat');
result_mtx(3,5) = result.acc(1);
result = load('./nuSVModel_1_nsp4.mat');
result_mtx(4,5) = result.acc(1);
result = load('./nuSVModel_25_nsp4.mat');
result_mtx(5,5) = result.acc(1);

result = load('./nuSVModel_001_nsp5.mat');
result_mtx(1,6) = result.acc(1);
result = load('./nuSVModel_01_nsp5.mat');
result_mtx(2,6) = result.acc(1);
result = load('./nuSVModel_05_nsp5.mat');
result_mtx(3,6) = result.acc(1);
result = load('./nuSVModel_1_nsp5.mat');
result_mtx(4,6) = result.acc(1);
result = load('./nuSVModel_25_nsp5.mat');
result_mtx(5,6) = result.acc(1);
