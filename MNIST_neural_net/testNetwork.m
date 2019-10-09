% Calculate accuracy of training and test set
% after training is done

train_outputActivations = zeros(nOutputs, nTrainPats);
test_outputActivations = zeros(nOutputs, nTestPats);

for pat = 1:nTrainPats,
    %%% forward pass
    inputStates = train_x(:,pat);
    inputStatesBias = [[inputStates]',[1]]';
    hiddenNetInputs = hiddenWeights * inputStatesBias;
    hiddenStates = sigmoidFunc(hiddenNetInputs);
    hidStatesBias = [[hiddenStates]',[1]]';
    outputNetInputs = outputWeights * hidStatesBias;
    outputStates = sigmoidFunc(outputNetInputs);
    
    %%% apply winner-take-all as correctness criterion
    [out, index] = max(outputStates);
    train_outputActivations(index,pat) = 1;
end

%%% calculating accuracy for training set
accVector = min((train_y == train_outputActivations),[],1);
train_acc = sum(accVector)/nTrainPats;
fprintf('training set accuracy = %3.1f%% \n',train_acc*100);

for pat = 1:nTestPats
    %%% forward pass
    inputStates = test_x(:,pat);
    inputStatesBias = [[inputStates]',[1]]';
    hiddenNetInputs = hiddenWeights * inputStatesBias;
    hiddenStates = sigmoidFunc(hiddenNetInputs);
    hidStatesBias = [[hiddenStates]',[1]]';
    outputNetInputs = outputWeights * hidStatesBias;
    outputStates = sigmoidFunc(outputNetInputs);
    
    %%% apply winner-take-all as correctness criterion
    [out, index] = max(outputStates);
    test_outputActivations(index,pat) = 1;
end

%%% calculating accuracy for test set
accVector = min((test_y == test_outputActivations),[],1);
test_acc = sum(accVector)/nTestPats;
fprintf('test set accuracy = %3.1f%% \n',test_acc*100);