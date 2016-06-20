function value = formula_eveluate(path)

load './labels.mat';

%% Segment
img = imread(path);
img_segs = image_segmentation(img);

%% Rcognitioin
nS = [];
for i = 1:size(img_segs,1)
    img = img_segs(i).Image;
    img = ~img;
    img = imresize(img,[40 40]);
	%imshow(img);
	[number prob] = classify(double(reshape(img,1,1600)));
    prob;
	label = labels{number,1};
	tnS = struct('BoundingBox', img_segs(i).BoundingBox, 'number', number, 'label', label);
	nS = [nS; tnS];
end

%% symbols used for interpreter
syms m n;

%% Interpreter
formula_stream = formula_interpret(nS);

%% Ealuation
value = eval(formula_stream);

end
