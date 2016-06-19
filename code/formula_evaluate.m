function value = formula_evaluate(S)

%%
PS = []; % previous struct
while (length(PS) ~= length(S))
    S = sort_struct(S);
    PS = S;
    SS = []; % sub struct
    idx = []; % index to be removed
    %
    for k = 1:length(S)
        switch (S(k).label)
            case '-' % minus vs. fraction
                [nr, dr] = frac_region(S(k).BoundingBox);
                numerator = [];
                denominator = [];
                for j = 1:length(S)
                    if (k == j)
                        continue;
                    end
                    if (rectint(nr, S(j).BoundingBox) > 0)
                        numerator = [numerator; S(j)];
                        idx = [idx, j];
                    end
                    if (rectint(dr, S(j).BoundingBox) > 0)
                        denominator = [denominator; S(j)];
                        idx = [idx, j]; % remove intersected symbols
                    end
                end
                %
                if (~isempty(numerator) && ~isempty(denominator))
                    TS = S(k);
                    TS.label = num2str(formula_evaluate(numerator) / formula_evaluate(denominator));
                    SS = [SS; TS];
                    idx = [idx, k]; % remove current symbols
                    break;
                end
                
            case {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9'}
                pr = power_region(S(k).BoundingBox);
                power = [];
                for j = 1:length(S)
                    if (k == j)
                        continue;
                    end
                    if ((rectint(pr, S(j).BoundingBox) > 0) && ismember(S(j).label, '0123456789'))
                        power = [power; S(j)];
                        idx = [idx, j]; % remove intersected symbols
                    end
                end
                if (~isempty(power))
                    TS = S(k);
                    TS.label = num2str(formula_evaluate(S(k)) ^ formula_evaluate(power));
                    SS = [SS; TS];
                    idx = [idx, k]; % remove current symbols
                    break;
                end
                
            case '='
                idx = [idx, k];
                break;
                
            case 'x'
                S(k).label = '*';
                
            case '('
                for h = 1:length(S)
                    if (~strcmp(S(h).label, ')'))
                        continue;
                    end
                end
                br = bracket_region(S(k).BoundingBox, S(j).BoundingBox);
                bracket = [];
                for j = 1:length(S)
                    if ((k == j) || (h == j))
                        continue;
                    end
                    if (rectint(br, S(j).BoundingBox) > 0)
                        bracket = [bracket; S(j)];
                        idx = [idx, j]; % remove intersected symbols
                    end
                end
                TS = S(k);
                TS.label = num2str(formula_evaluate(bracket));
                SS = [SS; TS];
                idx = [idx, k, h]; % remove current symbols
                break;
                
%             case {'sigma', 'pi'}
%                 [sym, smin, smax, sidx, tidx] = get_sym(S(k), S);
%                 TS = S(sidx);
%                 TS = sort_struct(TS);
%                 func = [];
%                 for j = 1:length(TS)
%                     func = strcat(func, TS(j));
%                 end
%                 if (strcmp(S(k).label, 'sigma'))
%                     ssym = symsum(func, sym, smin, smax);
%                 else
%                     ssym = symprod(func, sym, smin, smax);
%                 end
%                 TS = S(k);
%                 TS.label = num2str(ssym);
%                 SS = [SS; TS];
%                 idx = [idx, tidx, sidx];
%                 
            otherwise
                %
        end
    end
    S(idx) = [];
    S = [S; SS];
end

%% Evaluate
formula = '';
S = sort_struct(S);
for k = 1:length(S)
    formula = strcat(formula, S(k).label);
end
value = eval(formula);

end