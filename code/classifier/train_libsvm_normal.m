clear all;

addpath '../libsvm/unix';
addpath '../libsvm/window';

load '../data_normal.mat';

frac_label = 16;
total_train_data = 10815;
fold_num = 10;

% remove the 'frac' data (label == 16) for better training performance
X_train(t_train_double(:) == 16, :) = [];
t_train_double(t_train_double(:) == 16) = [];

% use crossvalind to pick up test data
indices = crossvalind('kfold', total_train_data, fold_num);

% choose fold-10 as testing data
test_indices = (indices == 10);
train_indices = ~test_indices;
% pick up training data
data_train = X_train(train_indices, :);
label_train = t_train_double(train_indices, :);
% pick up testing data
data_test = X_train(test_indices, :);
label_test = t_train_double(test_indices, :);

%% Debug
% im = reshape(X_train(randi(10000, 1), :), 40, 40);
% im = im';
% imshow(im);
%%


svm_model = svmtrain(label_train, data_train, '-s 1 -t 2 -c 1 -n 0.001 -b 1');
[predict acc est] = svmpredict(label_test, data_test, svm_model, '-b 1');
save -mat './nuSVModel_n.mat' svm_model predict acc est;

% svm_model = svmtrain(label_train, data_train, '-s 1 -t 2 -c 1 -n 0.01 -b 1');
% [predict acc est] = svmpredict(label_test, data_test, svm_model, '-b 1');
% save -mat './nuSVModel_01_n.mat' svm_model predict acc est;
% 
% svm_model = svmtrain(label_train, data_train, '-s 1 -t 2 -c 1 -n 0.05 -b 1');
% [predict acc est] = svmpredict(label_test, data_test, svm_model, '-b 1');
% save -mat './nuSVModel_05_n.mat' svm_model predict acc est;
% 
% svm_model = svmtrain(label_train, data_train, '-s 1 -t 2 -c 1 -n 0.1 -b 1');
% [predict acc est] = svmpredict(label_test, data_test, svm_model, '-b 1');
% save -mat './nuSVModel_1_n.mat' svm_model predict acc est;
