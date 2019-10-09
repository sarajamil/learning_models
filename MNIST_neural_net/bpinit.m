% related files: bp.m, outputDeltas.m, hiddenDeltas.m, sigmoidFunc.m,

%%%%%%%%%%%%%%% CREATE TRAINING PATTERNS %%%%%%%%%%%%%%%%%%%
%%% Load MNIST_data.mat to create the following variables:
%%%  train_x, train_y, test_x, test_y %%% 
load MNIST_data;
%%% Transpose these matrices so that each pattern X or 
%%% corresponding target output vector is a column vector
train_x = train_x';
train_y = train_y';
test_x = test_x';
test_y = test_y';
nTrainPats = size(train_x,2);
nTestPats = size(test_x,2);

%%%%%%%%%%%%% Initialize the network architecture %%%%%%%%%%
nInputs = size(train_x,1);
nHidden = 20;  %%% This can be changed as desired
nOutputs = size(train_y,1);
% initial random weights in [-.25,.25]
% The last element of each weight (row) vector is the bias 
hiddenWeights = .5 * (rand(nHidden,nInputs+1) - ones(nHidden,nInputs+1) * .5);
outputWeights = .5 * (rand(nOutputs,nHidden+1) - ones(nOutputs,nHidden+1) * .5);
hiddenStates = zeros(nHidden,1); 
outputStates = zeros(nOutputs,1);

%%%%%%%% Initialize the learning parameters %%%%%%%%%%%%%%%%%
nIters = 10; %% num learning iterations each time bp.m is called
epsilon = 0.75;  %% the learning rate can be changed as desired


