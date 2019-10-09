function output = testCL(input,W)
% Test the trained CL model with an input set
% eg. Ninputs = 2; Noutputs = 3
%       input = [1;0]
%       output = [0;0;1]

netInput = W*input;
%%% apply winner-take-all
% max() takes first instance of max value
% set max index = 1, otherwise = 0
[out, index] = max(netInput);
output = zeros(size(W,1), 1);
output(index) = 1;

end