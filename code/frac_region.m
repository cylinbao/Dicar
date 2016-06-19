function [numerator, denominator] = frac_region(bbox, bound)
% get the fraction interested regions

%%
if (nargin == 1)
    bound = 100;
end

%%
numerator = zeros(1, 4);
numerator(1) = bbox(1);
numerator(2) = bbox(2) - bound;
numerator(3) = bbox(3);
numerator(4) = bound;

%%
denominator = zeros(1, 4);
denominator(1) = bbox(1);
denominator(2) = bbox(2);
denominator(3) = bbox(3);
denominator(4) = bound;

end