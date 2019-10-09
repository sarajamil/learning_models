% Rumelhart & Zipser's
% Competitive Learning Model
clear all; close all; clc;

%%%%%%%%% Initialize

Ninputs = 2;
Noutputs = 3;
W = rand(Noutputs, Ninputs); %random initialization of Weights

for i = 1:Noutputs
    W(i,:) = W(i,:)/sum(W(i,:)); %normalize to have sum(row)=1
end

P = [0 1; 1 0; 1 1]'; %training patterns (input data)

Npats = size(P,2); %number of patterns = 3
Nreps = 100; %number of repetitions (of P)


%%%%%%%%%%% Train

g = 0.1; %learning rate

for rep = 1:Nreps
    for p = 1:Npats
        InputAC = P(:,p);
        netInput = W*InputAC;
        %%% apply winner-take-all
        % max() takes first instance of max value
        % set max index = 1, otherwise = 0
        [out, index] = max(netInput);
        OutputAC = zeros(Noutputs, 1);
        OutputAC(index) = 1;
        %%% apply Learning Rule
        % unit learns (weights update)
        % iff it wins the competition
        deltaW = zeros(Noutputs, Ninputs);
        deltaW(index,:) = g*(InputAC'./sum(InputAC) - OutputAC'*W);
        W = W + deltaW; %update the weights
    end
end


%%%%%%%%%%% Test

% Test the output model with the different input patterns.
% See whether there is a different unit that responds to
% one of each of the patterns.
% See what happens with a new input case [0;0].

out = zeros(Noutputs,size(P,2));
for i = 1:size(P,2)
    out(:,i) = testCL(P(:,i),W);
end
out
out_zero = testCL(zeros(Ninputs,1), W) %test the zero input case