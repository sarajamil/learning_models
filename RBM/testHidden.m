%%%%%%%%%%%%% Begin testHidden.m %%%%%%%%%%%%%%%%%%%%%
% present a test pattern to the hidden layer, update input layer, then do brief 
% Gibbs sampling, alternatingly updating the hidden and then the input layer

%% Test on TestHiddenPatterns
% Part 3 (question 4)
iState = zeros(nInputs, size(testHiddenPatterns,2));
iProb = zeros(nInputs, size(testHiddenPatterns,2));

for i = 1:size(testHiddenPatterns,2)
    [iState(:,i), iProb(:,i)] = backward(testHiddenPatterns(:,i), weights);
end

%% brief Gibbs = 5
% Part 4 (question 5)
for trial = 1:100
    for i = 1:4
        [iState, iProb] = backward(testHiddenPatterns(:,i), weights);
        for k = 1:5
            [hState, hProb] = forward(iState, weights);
            [iState, iProb] = backward(hState, weights);
        end
        iStateOut(:,i,trial) = iState;
        iProbOut(:,i,trial) = iProb;
    end
    compare = zeros(1,1); closestTrain = zeros(1,1); indexTrain = zeros(1,1);
    
    % comparing to training patterns
    for i = 1:4
        for j = 1:28
            compare(:,j) = trainingPatterns(:,j) == iStateOut(:,i,trial);
        end
        [closestTrain(1,i,trial), indexTrain(1,i,trial)] = max(sum(compare));
        closestTrain(1,i,trial) = closestTrain(1,i,trial)/13; %ratio of matching bits
    end
end


%%%%%%%%%%%%% End testHidden.m %%%%%%%%%%%%%%%%%%%%%
