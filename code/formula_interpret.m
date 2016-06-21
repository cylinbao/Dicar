function formula = formula_interpret(S)
%

%%
PS = []; % previous struct
while (~isequal(S, PS))
    S = sort_struct(S);
    PS = S;
    SS = []; % sub struct
    idx = []; % index to be removed
    %
    for k = 1:length(S)
        if (length(S(k).label) > 1) % processed elements
            continue;
        end
        
        switch (S(k).label)
            case '='
                idx = [idx, k];
                break;
                
            case 'x'
                S(k).label = '*';
                
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
                    SS = S(k);
                    SS.label = strcat('(', formula_interpret(numerator), ')/(', formula_interpret(denominator), ')');
                    idx = [idx, k]; % remove current symbols
                    break;
                end
                
            case {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'm', 'n'}
                interested_region = power_region(S(k).BoundingBox);
                interested_symbols = [];
                for j = 1:length(S)
                    if (k == j)
                        continue;
                    end
                    if (rectint(interested_region, S(j).BoundingBox) > 0 ...
                            && all(ismember(S(j).label, '0123456789')) && ...
                            S(j).BoundingBox(4) < 0.9 * S(k).BoundingBox(4) && ...
                            (S(j).BoundingBox(2) + S(j).BoundingBox(4) < S(k).BoundingBox(2) + S(k).BoundingBox(4) / 2))
                        interested_symbols = [interested_symbols; S(j)];
                        idx = [idx, j]; % remove intersected symbols
                    end
                end
                if (~isempty(interested_symbols))
                    SS = S(idx(1));
                    SS.label = strcat('^(', formula_interpret(interested_symbols), ')');
                    break;
                end
                
%             case '('
%                 for h = 1:length(S)
%                     if (~strcmp(S(h).label, ')'))
%                         continue;
%                     end
%                     break;
%                 end
%                 interested_region = bracket_region(S(k).BoundingBox, S(h).BoundingBox);
%                 interested_symbols = [];
%                 for j = 1:length(S)
%                     if ((k == j) || (h == j))
%                         continue;
%                     end
%                     if (rectint(interested_region, S(j).BoundingBox) > 0)
%                         if (S(j).BoundingBox(3) < interested_region(3))
%                             interested_symbols = [interested_symbols; S(j)];
%                             idx = [idx, j]; % remove intersected symbols
%                         end
%                     end
%                 end
%                 SS = S(k);
%                 SS.label = strcat('(', formula_interpret(interested_symbols), ')');
%                 idx = [idx, k, h]; % remove current symbols
%                 break;
                
            case {'s', 'p'} % sigma and pi
                [sym, smin, smax, sidx, fidx] = get_sym(k, S);
                TS = S(fidx);
                func = formula_interpret(TS);
                
                SS = S(k);
                if (strcmp(S(k).label, 's'))
                    SS.label = strcat('symsum(', func, ',', sym, ',', smin, ',', smax, ')');
                else
                    SS.label = strcat('symprod(', func, ',', sym, ',', smin, ',', smax, ')');
                end
                idx = [idx, k, sidx, fidx];
                break;
                
            case 'r' % square root
                interested_region = sqrt_region(S(k).BoundingBox);
                interested_symbols = [];
                for j = 1:length(S)
                    if (k == j)
                        continue;
                    end
                    if (rectint(interested_region, S(j).BoundingBox) > 0)
                        interested_symbols = [interested_symbols; S(j)];
                        idx = [idx, j]; % remove intersected symbols
                    end
                end
                if (~isempty(interested_symbols))
                    SS = S(k);
                    SS.label = strcat('sqrt(', formula_interpret(interested_symbols), ')');
                    idx = [idx, k];
                    break;
                end
                
            otherwise
                %
        end
    end
    S(idx) = [];
    S = [S; SS];
end

%% Intepret
formula = '';
S = sort_struct(S);
for k = 1:length(S)
    formula = strcat(formula, S(k).label);
end

end