function [deltas] = outputDeltas(output,target)
  % deltas, output, and target are all vectors

  %%% deltas is the vector of partial derivatives of the error
  %%% with respect to the net input to each unit
  sigmoidDeriv = output .* (ones(size(output)) - output);
  deltas = 2 * (output - target) .* sigmoidDeriv;

