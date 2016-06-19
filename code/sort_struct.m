function sorted = sort_struct(S)
% sorted = sort_struct(S)
% Sort struct by minimum horizontal axis of BoudingBox
%
% Varargins:
% - S: struct to be sorted
%
% Varargouts:
% - Sorted struct

%%
size = length(S);
for i = 1:size
    for j = 1:size
        if (S(i).BoundingBox(1) < S(j).BoundingBox(1)) % sort by h_min
            temp = S(i);
            S(i) = S(j);
            S(j) = temp;
        end
    end
end
sorted = S;

end