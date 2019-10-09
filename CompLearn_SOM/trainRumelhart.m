function [newWeights] = trainRumelhart(oldWeights, InputPatterns, learningRate, numIterations)
% Training function
% Rumelhart & Zipser's
% Competitive Learning Model

W = oldWeights;
g = learningRate;
Nreps = numIterations;
Npats = size(InputPatterns,2);

for rep = 1:Nreps
    for p = 1:Npats
        InputAC = InputPatterns(:,p);
        OutputAC = WinnerTakeAll(W, InputAC); % apply Winner-Take-All
        
        %%% apply Learning Rule
        % unit learns iff it wins the competition
        deltaWwinner = g*(InputAC'./sum(InputAC) - OutputAC'*W);
        deltaW = OutputAC*deltaWwinner;
        W = W + deltaW; % update the weights
    end
end

newWeights = W;

end