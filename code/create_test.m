clear; close all; clc;

im = imread('level2.png');
S = image_segmentation(im);

numfids = length(S);

X_test = false(numfids, 40*40);
t_test = cell(numfids, 1);
for k = 1:numfids
    sub_im = S(k).Image;
    sub_im = imresize(sub_im, [40, 40]);
    imshow(sub_im);
    X_test(k, :) = reshape(sub_im', 40*40, 1);
    t_test{k} = {input('Label: ', 's')};
end