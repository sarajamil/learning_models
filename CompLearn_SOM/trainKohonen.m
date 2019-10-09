function [newWeights] = trainKohonen(oldWeights, InputPatterns, slope, learningRate, numIterations)
% Training function
% Kohonen's Model
% Self-organizing map (SOM)
% 
% (includes input for slope of neighbourhood function)

W = oldWeights;
g = learningRate;
Nreps = numIterations;
Npats = size(InputPatterns,2);
m = slope;
Noutputs = size(W,1);

for rep = 1:Nreps
    for p = 1:Npats
        InputAC = InputPatterns(:,p);
        OutputAC = WinnerTakeAll(W, InputAC); % apply Winner-Take-All
        
        %%% neighbourhood function
        % decreases linearly with distance from the winner
        i = find(OutputAC>0);
        neigh = zeros(size(OutputAC));
        for x = 1:length(OutputAC)
            if(x<=i)
                neigh(x) = m*(x-i)+1;
            else
                neigh(x) = -m*(x-i)+1;
            end
        end
        neigh(neigh<0) = 0;
        
        %%% apply Learning Rule
        % same learning rule with addition of neighbourhood function
        deltaW = zeros(size(W));
        for k = 1:Noutputs
            deltaW(k,:) = g*neigh(k)*(InputAC'./sum(InputAC) - W(k,:));
            W(k,:) = W(k,:) + deltaW(k,:); % update the weights
        end
    end
end

newWeights = W;

end