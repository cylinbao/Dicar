function result = formula_evaluate(path)
%%

%%
addpath './libsvm/unix';
addpath './libsvm/window';
load 'classifier/nuSVModel_nr.mat';
load 'labels.mat';
syms m n;

%% Segment
img = imread(path);
S = image_segmentation(img);

%% Recognitioin
nS = [];
symbols = [];
for i = 1:length(S)
    img = S(i).Image;
    imsize = size(img);
    if (imsize(1) > imsize(2))
        pad = [0, round((imsize(1) - imsize(2)) / 2)];
    else
        pad = [round((imsize(2) - imsize(1)) / 2), 0];
    end
    img = padarray(img, pad);
    img = double(imresize(img,[40 40]));
% 	imshow(img);
	[number, prob] = classify(img);
	label = labels{number,1};
    tnS = struct('BoundingBox', S(i).BoundingBox, 'number', number, 'label', label);
	nS = [nS; tnS];
    symbols = strcat(symbols, label);
end
% Remove '='
% if (strcmp(nS(end).label, '='))
%     nS(end) = [];
% elseif(strcmp(nS(end).label, '-') && strcmp(nS(end - 1).label, '-'))
%     nS(end) = [];
%     nS(end) = [];
% end
if ((nS(end-1).BoundingBox(1) + nS(end-1).BoundingBox(3)/2 > nS(end).BoundingBox(1)) && ...
        (nS(end-1).BoundingBox(1) + nS(end-1).BoundingBox(3)/2 < nS(end).BoundingBox(1) + nS(end).BoundingBox(3)) && ...
        (nS(end).BoundingBox(1) + nS(end).BoundingBox(3)/2 > nS(end-1).BoundingBox(1)) && ...
        (nS(end).BoundingBox(1) + nS(end).BoundingBox(3)/2 < nS(end-1).BoundingBox(1) + nS(end-1).BoundingBox(3)))
    nS(end) = [];
    nS(end) = [];
else
    nS(end) = [];
end

%% Interpreter
try
    formula = formula_interpret(nS);
catch
    warning('Problem at evaluation, set result to 0');
    result = 0;
    return;
end

%% Ealuation
try
    result = eval(formula);
    if (~isnumeric(result))
        result = str2double(char(result));
    end
catch
    warning('Problem at evaluation, set result to 0');
    result = 0;
    return;
end

end
