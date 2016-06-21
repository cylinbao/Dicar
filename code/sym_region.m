function [top, bot, mid] = sym_region(bbox, bound)

%%
if (nargin == 1)
    bound = 1000;
end
expand = bbox(4) / 2;

%%
top = zeros(1, 4);
top(1) = bbox(1);
top(2) = bbox(2) - bbox(4) / 2;
top(3) = bbox(3);
top(4) = bbox(4) / 2;
%%
bot = zeros(1, 4);
bot(1) = bbox(1);
bot(2) = bbox(2) + bbox(4) - expand;
bot(3) = bbox(3) + expand;
bot(4) = bbox(4) / 2 + 2 * expand;
%%
mid = zeros(1, 4);
mid(1) = bbox(1) + bbox(3);
mid(2) = bbox(2);
mid(3) = mid(1) + bound;
mid(4) = bbox(4);
end
