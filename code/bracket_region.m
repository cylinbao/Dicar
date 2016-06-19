function [bracket] = bracket_region(openBbox, closeBbox)

bracket = zeros(1, 4);
bracket(1) = openBbox(1);
bracket(2) = min(openBbox(2), closeBbox(2));
bracket(3) = closeBbox(1) + closeBbox(3) - openBbox(1);
bracket(4) = max(openBbox(4), closeBbox(4));
end