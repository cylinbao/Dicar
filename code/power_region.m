function [power] = power_region(bbox)
% get the power interested regions

%%
power = zeros(1, 4);
power(1) = bbox(1) + bbox(3);
power(2) = bbox(2) - bbox(4) / 2;
power(3) = bbox(4) / 2;
power(4) = bbox(4) / 2;
end