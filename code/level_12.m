% Eval for level 1+2
clear; close all; clc;

load('saved.mat');
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
            
        case '='
            break; % remove last '='
            
        case 'x'
            s = '*'; % replace '*'
            
        otherwise
            
    end
    formula = strcat(formula, s);
end

eval(formula)