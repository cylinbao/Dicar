% A classifier with hand-written symbols based on libsvm
function [predict acc est] = classify(x)

addpath './libsvm/libsvm_unix'
load './classifier/nuSVModel.mat';

[predict acc est] = svmpredict(0, x, svm_model, '-b 1');

end
