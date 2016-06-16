%% Load all notations and concat them

fnames = dir('notations');
numfids = length(fnames);

X_train = [];
t_train = [];
for k = 1:numfids
    symbol = fnames(k).name;
    if(strcmp(symbol, '.') || strcmp(symbol, '..'))
        continue;
    end
    [X, t] = read_images(40, 40, symbol, strcat('notations/', symbol));
    X_train = [X_train; X];
    t_train = [t_train; t];
end