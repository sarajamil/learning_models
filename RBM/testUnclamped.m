%%%%%%%%%%%%% Begin testUnclamped.m %%%%%%%%%%%%%%%%%%%%%
clear all; close all; clc;

%%% the training part
% Part 1 (questions 1 and 2)
init;
run = 700; %run*100 actual runs
W = [];
Gerror = [];

for t = 1:run
    [weights,G] = train(weights,nLearnReps,K,epsilon,trainingPatterns,weightCost);
    W(:,t) = reshape(weights(1:(nHidden-1),1:12),(nHidden-1)*12,1);
    Gerror(t) = G;
end

figure(1)
plot(1:run,W','o-');
title('Weights vs. runs');
xlabel('number of training runs (*100)');
ylabel('Weight values');

%%% diff averaged
Gdiff = diff(Gerror);
% Gdiff = diff(downsample(Gerror,5)); %downsampled
Gdiff = mean(reshape([Gdiff,0],[10,70]),1); %averaged for 10 runs
figure(2)
plot(abs(Gdiff));
title('Energy difference vs. runs');
xlabel('number of training runs (*100)');
ylabel('G-error');

%%%%%%%%%%%%% End testUnclamped.m %%%%%%%%%%%%%%%%%%%%%
