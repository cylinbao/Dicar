function data = read_images(h_size, v_size, location)
%

%%
if(nargin == 2)
    location = '.';
end

%%
fnames = dir(strcat(location, '/*.png'));
numfids = length(fnames);
size = h_size * v_size;
data = false(numfids, size);
for k = 1:numfids
    im = imread(fnames(k).name);
    if(ndims(im) == 3) % RGB image
        im = rgb2gray(im);
    end
    threshold = graythresh(im);
    im = im2bw(im,threshold);
    im = imresize(im, [v_size, h_size]);
    data(k, :) = reshape(im', size, 1);
end

end
