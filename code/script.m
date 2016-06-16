clear; close all; clc;

im = imread('im.png');
if(ndims(im) == 3)
    im = rgb2gray(im);
end

thresh = graythresh(im);
bw = im2bw(im, thresh);
bw = bwareaopen(bw, 100);
bw_ = ~bw;

CC = bwconncomp(bw_);
S = regionprops(CC, 'Image', 'BoundingBox');

numfids = length(S);
for k = 1:numfids
    sub_im = S(k).Image;
    imshow(sub_im);
    pause(1);
end