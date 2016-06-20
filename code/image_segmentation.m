function S = image_segmentation(im)
% S = image_segmentation(im)
%
% Varargins:
% - im: input image
%
% Varargouts:
% - S: struct
%

%% Convert to binary image
if(ndims(im) == 3) % RGB image
    im = rgb2gray(im);
end
threshold = graythresh(im);
% threshold = 0.2;
bw = im2bw(im, threshold);

%% Remove all object containing fewer than 100 pixels
bw = bwareaopen(bw, 100);

%% Erosion then Dilation
% imagen = bwmorph(imagen, 'thin', 5);
% imagen = bwmorph(imagen, 'thicken', 5);

%% Segment
% Label connected components
CC = bwconncomp(bw);
% Measure properties of image regions
S = regionprops(CC, 'Image', 'BoundingBox');

end