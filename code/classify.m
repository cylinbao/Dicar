% A classifier with hand-written symbols based on libsvm
function [predict, probability] = classify(x)

addpath './libsvm/unix'

radial = load ('./classifier/nuSVModel_nr.mat');
linear = load ('./classifier/nuSVModel_nl.mat');
poly = load ('./classifier/nuSVModel_np.mat');
hog = load ('./classifier/nuSVModel_nh.mat');

vec = reshape(x',1,1600);
fet = double(extractHOGFeatures(x));

[predict_r, ~, est_r] = svmpredict(zeros(size(vec,1),1), vec, radial.svm_model, '-b 1');
[predict_l, ~, est_l] = svmpredict(zeros(size(vec,1),1), vec, linear.svm_model, '-b 1');
[predict_p, ~, est_p] = svmpredict(zeros(size(vec,1),1), vec, poly.svm_model, '-b 1');
[predict_h, ~, est_h] = svmpredict(zeros(size(fet,1),1), fet, hog.svm_model, '-b 1');

predict_vec = [predict_r, predict_l, predict_p, predict_h];
%%
% minus one for the type '17~22', cause 'est' only contains '21' columns
% becuase it lacks of type '16' which is 'frac'
predict_rt = predict_r - (predict_r > 16);
probability_r = est_r(predict_rt);

predict_ht = predict_h - (predict_h > 16);
probability_h = est_h(predict_ht);

predict_lt = predict_l - (predict_l > 16);
probability_l = est_l(predict_lt);

predict_pt = predict_p - (predict_p > 16);
probability_p = est_p(predict_pt);

probability_vec = [probability_r, probability_l, probability_p, probability_h];
best_idx = find(probability_vec == max(probability_vec));
probability = probability_vec(best_idx);
predict = predict_vec(best_idx);

end
