%%%%%%%%%%%%% Begin testInput.m %%%%%%%%%%%%%%%%%%%%%
% present a test input pattern to the input layer, update hidden layer, then do brief 
% Gibbs sampling, alternatingly updating the input and then the hidden layer

%% Test on TestInputPatterns
% Part 2 (question 3)
hState = zeros(nHidden, size(testInputPatterns,2));
hProb = zeros(nHidden, size(testInputPatterns,2));

for i = 1:size(testInputPatterns,2)
    [hState(:,i), hProb(:,i)] = forward(testInputPatterns(:,i), weights);
end

%% Test on TrainingPatterns
% hState_train = zeros(nHidden, size(trainingPatterns,2));
% hProb_train = zeros(nHidden, size(trainingPatterns,2));
% 
% for i = 1:size(trainingPatterns,2)
%     [hState_train(:,i), hProb_train(:,i)] = forward(trainingPatterns(:,i), weights);
% end


%% brief Gibbs = 10
% Part 5 (question 6)
% starting with random input state
for trial = 1:100
    iState = rand(13,1);
    iState(iState>=0.5) = 1;
    iState(iState<0.5) = 0;
    for k = 1:10
        [hState, hProb] = forward(iState, weights);
        [iState, iProb] = backward(hState, weights);
    end
    I_iStateOut(:,trial) = iState;
    I_iProbOut(:,trial) = iProb;

    % comparing to training patterns
    for j = 1:28
        compare(:,j) = trainingPatterns(:,j) == I_iStateOut(:,trial);
    end
    [I_closestTrain(1,trial), I_indexTrain(1,trial)] = max(sum(compare));
    I_closestTrain(1,trial) = I_closestTrain(1,trial)/13; 
end

% starting with random hidden state
for trial = 1:100
    hState = rand(5,1);
    hState(hState>=0.5) = 1;
    hState(hState<0.5) = 0;
    for k = 1:10
        [iState, iProb] = backward(hState, weights);
        [hState, hProb] = forward(iState, weights);
    end
    H_iStateOut(:,trial) = iState;
    H_iProbOut(:,trial) = iProb;
    
    % comparing to training patterns
    for j = 1:28
        compare(:,j) = trainingPatterns(:,j) == H_iStateOut(:,trial);
    end
    [H_closestTrain(1,trial), H_indexTrain(1,trial)] = max(sum(compare));
    H_closestTrain(1,trial) = H_closestTrain(1,trial)/13; 
end

%%%%%%%%%%%%% End testInput.m %%%%%%%%%%%%%%%%%%%%%