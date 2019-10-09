function [outputActivations] = WinnerTakeAll(WeightMatrix, InputPattern)
% Winner-take-all
% max() takes first instance of max value
% set max index = 1, otherwise = 0

Noutputs = size(WeightMatrix,1);
netInput = WeightMatrix*InputPattern;

[out, index] = max(netInput);
outputActivations = zeros(Noutputs, 1);
outputActivations(index) = 1;

end