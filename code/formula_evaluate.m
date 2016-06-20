function nS = formula_eveluate(path)

load './labels.mat';

%% Segment
img = imread(path);
img_segs = image_segmentation(img);

%% Rcognitioin
nS = [];
for i = 1:size(img_segs,1)
	imshow(img_segs(i).Image);
	number = classify(double(reshape(imresize(img_segs(i).Image,[40 40]),1,1600)));
	label = labels{number,1}
	tnS = struct('BoundingBox', img_segs(i).BoundingBox, 'number', number, 'label', label);
	nS = [nS; tnS];
end

%% symbols used for interpreter
syms m n;

%% Interpreter
%formula = formula_intepret(nS);

%% Ealuation
%value = eval(formula);

end
