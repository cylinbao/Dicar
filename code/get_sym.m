function [sym, smin, smax, sidx, fidx] = get_sym(k, S)
%

%%
sidx = [];
fidx = [];
smin = [];
smax = [];

%% Top and bot parts
[tr, br, mr] = sym_region(S(k).BoundingBox);
for j = 1:length(S)
    if (k == j)
        continue;
    end
    if (rectint(tr, S(j).BoundingBox) > 0)
        sidx = [sidx, j]; % remove intersected symbols
        if (ismember(S(j).label, '0123456789'))
            smax = strcat(smax, S(j).label);
        end
    end
    if (rectint(br, S(j).BoundingBox) > 0)
        sidx = [sidx, j]; % remove intersected symbols
        if (ismember(S(j).label, '0123456789'))
            smin = strcat(smin, S(j).label);
        elseif (ismember(S(j).label, 'mn'))
            sym = S(j).label;
        end
    end
end

%% Main part
for j = 1:length(S)
    if (rectint(mr, S(j).BoundingBox) > 0)
        fidx = [fidx, j]; % symbols of main part
        if (strcmp(S(j).label, '('))
            for h = 1:length(S)
                if (~strcmp(S(h).label, ')'))
                    continue;
                end
                break;
            end
            interested_region = bracket_region(S(k).BoundingBox, S(h).BoundingBox);
            for l = 1:length(S)
                if ((j == l) || (h == l))
                    continue;
                end
                if (rectint(interested_region, S(j).BoundingBox) > 0)
                    fidx = [fidx, l]; % remove intersected symbols
                end
            end
        elseif (strcmp(S(j).label, sym))
            break;
        end
    end
end

%% Power part
interested_region = power_region(S(j).BoundingBox);
for j = 1:length(S)
    if (k == j)
        continue;
    end
    if ((rectint(interested_region, S(j).BoundingBox) > 0) && all(ismember(S(j).label, '0123456789')))
        fidx = [fidx, j]; % symbols of main part
    end
end

end