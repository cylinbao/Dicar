% Eval for level 1+2

SS = level2;
num = length(SS);

formula = '';
for k = 1:num
    s = SS(k).label;
    
    switch(SS(k).label)
        case '-'
            if(strcmp(SS(k+1).label, '-'))
                break; % remove last '='
            end
            
            h_min = SS(k).BoundingBox(1);
            h_max = h_min + SS(k).BoundingBox(3);
            
        case '='
            break; % remove last '='
            
        case 'x'
            s = '*'; % replace '*'
            
        otherwise
            
    end
    formula = strcat(formula, s);
end

eval(formula)