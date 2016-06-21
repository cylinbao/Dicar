% A classifier with hand-written symbols based on libsvm
function [predict, probability] = classify(x)

addpath './libsvm/unix'
load './classifier/nuSVModel_n.mat';

[predict, acc, est] = svmpredict(zeros(size(x,1),1), x, svm_model, '-b 1');

%% Debug
% load('labels.mat');
% im = reshape(x, 40, 40);
% im = im';
% imshow(im);
% label = labels{predict, 1};

%%
% minus one for the type '17~22', cause 'est' only contains '21' columns
% becuase it lacks of type '16' which is 'frac'
predict_t = predict - (predict > 16);

for i=1:size(predict_t,1)
	probability(i,1) = est(i, predict_t(i));
end

end
