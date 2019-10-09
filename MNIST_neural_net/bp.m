for i = 1:nIters
  sumSqrError = 0.0;
  outputWGrad = zeros(size(outputWeights));
  hiddenWGrad = zeros(size(hiddenWeights));
  
  for pat = 1:nTrainPats,
    %%%%% forward pass %%%%%
    inputStates = train_x(:,pat);
    inputStatesBias = [[inputStates]',[1]]';
    hiddenNetInputs = hiddenWeights * inputStatesBias;
    hiddenStates = sigmoidFunc(hiddenNetInputs);
    % Add a '1' to the hidden state vector representing the bias
    % unit's input to the output layer
    hidStatesBias = [[hiddenStates]',[1]]';
    target = train_y(:,pat);
    outputNetInputs = outputWeights * hidStatesBias;
    outputStates = sigmoidFunc(outputNetInputs);
    
    %%%%% backward pass %%%%%
    diff = outputStates - target;
    sumSqrError = sumSqrError + sum(diff' * diff);
    
    %%%%%%%%%%%% Calculate Deltas %%%%%%%%%%%%%%%%%%%%%%%%%
    % Delta is an intermediary term for computing the weight change.
    % For each unit i, delta_i is the derivative
    % of the error with respect to the ith unit's net input
    outputDel = outputDeltas(outputStates,target);
    hiddenDel = hiddenDeltas(outputDel,hidStatesBias,outputWeights);
    
    %%%%%%%%%%%% Calculate gradients %%%%%%%%%%%%%%%%%%%%%%%%%%
    % The gradient is the vector of derivatives of the error with 
    % respect to each weight.
    outputWGrad = outputWGrad + outputDel * hidStatesBias';
    hiddenWGrad = hiddenWGrad + hiddenDel(1:nHidden,:) * inputStatesBias';
  end
  
  MSE(1,size(MSE,2)+1) = sumSqrError / nTrainPats;
  
  % There are 60,000 MNIST training patterns so for batch learning
  % it's important to divide the weight change by the number of 
  % patterns. For online learning / stochastic gradient descent,
  % this division by nTrainPats would not be necessary.
  
  outputWGrad = outputWGrad / nTrainPats;
  hiddenWGrad = hiddenWGrad / nTrainPats;
  outputWeights = outputWeights - epsilon * outputWGrad;
  hiddenWeights = hiddenWeights - epsilon * hiddenWGrad;
  gradSize(1,size(gradSize,2)+1) = norm([hiddenWGrad(:);outputWGrad(:)]);
  fprintf(1,'E=%f, |G|=%f\n',MSE(1,size(MSE,2)),gradSize(1,size(gradSize,2)));
end

