clear; close all; clc;

im = imread('level3.png');
S = image_segmentation(im);

numfids = length(S);

OS = [];
for k = 1:numfids
    SS = S(k);
    imshow(SS.Image);
    [SS(:).label] = deal(input('Label: ', 's'));
    OS = [OS; SS];
end