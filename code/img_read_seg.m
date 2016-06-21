function varargout = img_read_seg(varargin)
% [X, t] = read_images(h_size, v_size, label, location)
% Read all PNG images in a directory
%
% Varargins:
% - h_size: horizontal size
% - v_size: vertical size
% - label: output label
% - location: relative path of directory
%
% Varargouts:
% - X: logical matrix of images
% - t: cell array of label
%

%%
switch(nargin)
    case 0
        h_size = 40;
        v_size = 40;
        label = 0;
        location = '.';
    case 2
        h_size = varargin{1};
        v_size = varargin{2};
        label = 0;
        location = '.';
    case 3
        h_size = varargin{1};
        v_size = varargin{2};
        label = varargin{3};
        location = '.';
    case 4
        h_size = varargin{1};
        v_size = varargin{2};
        label = varargin{3};
        location = varargin{4};
    otherwise
        error('Wrong number of input');
end

%%
fnames = dir(strcat(location, '/*.png'));
numfids = length(fnames);
size = h_size * v_size;
X = false(numfids, size);
for k = 1:numfids
		fnames(k).name
    im = imread(strcat(location, '/', fnames(k).name));
		img_seg = image_segmentation(im);
    im = imresize(img_seg(1).Image, [v_size, h_size]);
		im = ~im;
    X(k, :) = reshape(im, 1, size);
end

%%
t = repmat({label}, numfids, 1); %label * ones(numfids, 1);

%%
imshow(im);

%%
varargout{1} = X;
if(nargout == 2)
    varargout{2} = t;
elseif(nargout == 3)
    varargout{2} = t;
    varargout{3} = img_seg;
end

end
