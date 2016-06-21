clear all;

% read result from each type of models
result = load('./nuSVModel_001_n.mat');
result_mtx(1,1) = result.acc(1);
result = load('./nuSVModel_01_n.mat');
result_mtx(2,1) = result.acc(1);
result = load('./nuSVModel_05_n.mat');
result_mtx(3,1) = result.acc(1);
result = load('./nuSVModel_1_n.mat');
result_mtx(4,1) = result.acc(1);
result = load('./nuSVModel_25_n.mat');
result_mtx(5,1) = result.acc(1);

result = load('./nuSVModel_001_nl.mat');
result_mtx(1,2) = result.acc(1);
result = load('./nuSVModel_01_nl.mat');
result_mtx(2,2) = result.acc(1);
result = load('./nuSVModel_05_nl.mat');
result_mtx(3,2) = result.acc(1);
result = load('./nuSVModel_1_nl.mat');
result_mtx(4,2) = result.acc(1);
result = load('./nuSVModel_25_nl.mat');
result_mtx(5,2) = result.acc(1);

result = load('./nuSVModel_001_np2.mat');
result_mtx(1,3) = result.acc(1);
result = load('./nuSVModel_01_np2.mat');
result_mtx(2,3) = result.acc(1);
result = load('./nuSVModel_05_np2.mat');
result_mtx(3,3) = result.acc(1);
result = load('./nuSVModel_1_np2.mat');
result_mtx(4,3) = result.acc(1);
result = load('./nuSVModel_25_np2.mat');
result_mtx(5,3) = result.acc(1);

result = load('./nuSVModel_001_np3.mat');
result_mtx(1,4) = result.acc(1);
result = load('./nuSVModel_01_np3.mat');
result_mtx(2,4) = result.acc(1);
result = load('./nuSVModel_05_np3.mat');
result_mtx(3,4) = result.acc(1);
result = load('./nuSVModel_1_np3.mat');
result_mtx(4,4) = result.acc(1);
result = load('./nuSVModel_25_np3.mat');
result_mtx(5,4) = result.acc(1);

result = load('./nuSVModel_001_np4.mat');
result_mtx(1,5) = result.acc(1);
result = load('./nuSVModel_01_np4.mat');
result_mtx(2,5) = result.acc(1);
result = load('./nuSVModel_05_np4.mat');
result_mtx(3,5) = result.acc(1);
result = load('./nuSVModel_1_np4.mat');
result_mtx(4,5) = result.acc(1);
result = load('./nuSVModel_25_np4.mat');
result_mtx(5,5) = result.acc(1);

result = load('./nuSVModel_001_np5.mat');
result_mtx(1,6) = result.acc(1);
result = load('./nuSVModel_01_np5.mat');
result_mtx(2,6) = result.acc(1);
result = load('./nuSVModel_05_np5.mat');
result_mtx(3,6) = result.acc(1);
result = load('./nuSVModel_1_np5.mat');
result_mtx(4,6) = result.acc(1);
result = load('./nuSVModel_25_np5.mat');
result_mtx(5,6) = result.acc(1);
