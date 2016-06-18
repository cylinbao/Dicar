% A classifier with hand-written symbols based on libsvm
function [predict acc est] = classifier(x)

load './classifier/nvSVModel.mat';

[predict acc est] = svmpredict(0, x, svm_model, '-b 1');

end
