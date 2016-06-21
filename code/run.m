%%
clear; close all; clc;

path = 'formulas';
fnames = dir(path);

for k = 1:length(fnames)
    if(strcmp(fnames(k).name, '.') || strcmp(fnames(k).name, '..'))
        continue;
    end
    fprintf('Accessing directory: %s\n', fnames(k).name);
    subpath = strcat(path, '/', fnames(k).name);
    subfnames = dir(subpath);
    
    imgnames = [];
    for j = 1:length(subfnames)
        name = subfnames(j).name;
        if(strcmp(name, '.') || strcmp(name, '..'))
            continue;
        end
        if(strcmp(name(end-2:end), 'png'))
            imgnames = [imgnames; {subfnames(j).name}];
        end
    end
    imgnames = sort_nat(imgnames);
    
    Y_test = zeros(length(imgnames), 1);
    for j = 1:length(imgnames)
        imgpath = strcat(subpath, '/', imgnames{j});
        Y_test(j) = formula_evaluate(imgpath);
    end
    save(strcat(path, '/', fnames(k).name, '/Y_test.mat'), 'Y_test');
end
