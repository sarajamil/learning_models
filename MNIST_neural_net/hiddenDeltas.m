function [deltas] = hiddenDeltas(outputDeltas,hiddenOutputs,outputWeights)
  % deltas and outputs are column vectors. 

  % outputWeights is the matrix of hidden->output weights (each row is the
  % weight vector of an output unit).

  %%% deltas is the vector of partial derivatives of the error
  %%% with respect to the net input to each unit

  sigmoidDeriv = hiddenOutputs .* (ones(size(hiddenOutputs)) - hiddenOutputs);
  deltas = (outputWeights' * outputDeltas) .* sigmoidDeriv;

