%% Load all notations and concat them
clear; close all;
path = 'dataset/black_digit/normal/notations';
fnames = dir(path);
numfids = length(fnames);

X_train = [];
t_train = [];
t_train_double = [];
labels = [];
idx = 1;
c = cell(1, 2);
for k = 1:numfids
    symbol = fnames(k).name;
    if(strcmp(symbol, '.') || strcmp(symbol, '..'))
        continue;
    end
    [X, t, img_seg] = img_read_seg(40, 40, symbol, strcat(path, '/', symbol));
    t_double = idx * ones(length(t), 1);
    X_train = [X_train; X];
    t_train = [t_train; t];
    c = [{symbol}, {idx}];
    labels = [labels; c];
    idx = idx + 1;
    t_train_double = [t_train_double; t_double];
end
