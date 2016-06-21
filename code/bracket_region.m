function [bracket] = bracket_region(openBbox, closeBbox)
%%
expand = min(openBbox(2), closeBbox(2)) / 4;

%%
bracket = zeros(1, 4);
bracket(1) = openBbox(1);
bracket(2) = min(openBbox(2), closeBbox(2)) - expand;
bracket(3) = closeBbox(1) + closeBbox(3) - openBbox(1);
bracket(4) = max(openBbox(2) + openBbox(4), closeBbox(2) + closeBbox(4)) - bracket(2) + 2 * expand;
end