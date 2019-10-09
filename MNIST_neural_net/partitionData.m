function [trainX,trainY,valX,valY] = partitionData(X,Y,proportion)
% Takes a dataset X with labels Y and partitions it into a smaller training 
% set and a validation set. The size of the validation set is determined by
% 'proportion', which is the proportion of samples that will be used to
% form the validation set. The value of 'proportion' must be between 0 and
% 1.
% Example: [traiinX,trainY,valX,valY] = partitionData(train_x,train_y,0.25)

% Convert pixel intensity values to 0-1 range
X = X/255;

% Get the size of the full data set and compute the number of training
% samples 
N = size(X,1);
Ntrain = floor(N*proportion);

% Get randomized unique indices for training samples and validation
% samples
p = randperm(N);
train_idx = p(1:Ntrain);
val_idx = p(Ntrain+1:N);

% Output separate training and validation sets
trainX = X(train_idx,:);
trainY = Y(train_idx,:);
valX = X(val_idx,:);
valY = Y(val_idx,:);

[trainX,mu,sigma] = zscore(trainX);
valX = bsxfun(@minus,valX,mu);
valX = bsxfun(@rdivide,valX,sigma);