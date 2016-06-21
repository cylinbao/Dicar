function value = formula_evaluate(path)

load './labels.mat';
addpath 'libsvm/unix';
addpath 'libsvm/window';

%% Segment
img = imread(path);
img_segs = image_segmentation(img);

%% Rcognitioin
nS = [];
for i = 1:size(img_segs,1)
    img = img_segs(i).Image;
    imsize = size(img);
    if (imsize(1) > imsize(2))
        pad = [0, round((imsize(1) - imsize(2)) / 2)];
    else
        pad = [round((imsize(2) - imsize(1)) / 2), 0];
    end
    img = padarray(img, pad);
    img = double(imresize(img,[40 40]));
% 	imshow(img);
	[number, prob] = classify(reshape(img',1,1600));
	label = labels{number,1};
	tnS = struct('BoundingBox', img_segs(i).BoundingBox, 'number', number, 'label', label);
	nS = [nS; tnS];
end

%% Interpreter
formula = formula_interpret(nS);

%% Ealuation
syms m n;
value = eval(formula);

end
