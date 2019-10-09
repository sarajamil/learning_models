%%%%%%%%% Initialize
% A script that sets global variables, e.g. layer sizes, learning rates, 
% initial weights, training patterns. This will be called once from the 
% command line for each simulated model that you run.

% training patterns (input data)
P = zeros(15,11);
for i = 1:11
    P(i:i+4,i) = 1;
end

Npats = size(P,2); %number of training patterns
Ninputs = size(P,1); %number of input units
Noutputs = 11;
m = 0.8; %slope of linear neighbourhood function (Kohonen)

Nreps = 100; %number of repetitions (of P)
g = 0.1; %learning rate

W = rand(Noutputs, Ninputs); %random initialization of Weights

for i = 1:Noutputs
    W(i,:) = W(i,:)/sum(W(i,:)); %normalize to have sum(row)=1
end

% % testing algorithm with non-binary inputs
% P = [5 2 1 0 0;
%     2 5 2 1 0;
%     1 2 5 2 1;
%     0 1 2 5 2;
%     0 0 1 2 5]';
% 
% Noutputs = 5;