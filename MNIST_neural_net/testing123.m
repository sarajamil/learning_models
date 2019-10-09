% PSYCH 734/CSE 734
% Assignment 3
% Sara Jamil

%% Training bp with batch learning
clear; close all; clc;

bpinit

MSE = [];
gradSize = [];

bp %first run
for i = 1:49 %max 500 iterations total
    i %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % calculating the change in MSE
    % for last 10 iterations
    clear diff %inconvenient name
    MSEd = abs(sum(diff(MSE(1,(length(MSE)-9):end)))/9);
    
    % stopping criterion:
    % last MSE must be below 0.4 AND
    % change in MSE averaged over last 10 runs is less than 0.003
    if(MSE(1,end)<=0.4)&&(MSEd<=0.003)
        break;
    else
        % run training
        bp %nIters = 10 (each bp call)
    end
    
end

figure(1)
plot(MSE);
title('MSE');

figure(2)
plot(gradSize);
title('gradSize');

testNetwork


%% Training bp with online learning
clear; clc;

bpinit

% change the learning rate
epsilon = 0.01; %chosen after many trials

MSE = [];
gradSize = [];

bponline %first run
for i = 1:49 %max 500 iterations total
    i %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % calculating the change in MSE
    % and the averaged MSE
    % for last 10 iterations
    clear diff %inconvenient name
    MSEd = abs(sum(diff(MSE(1,(length(MSE)-9):end)))/9);
    MSEa = sum(MSE(1,(length(MSE)-9):end))/10;
    
    % stopping criterion:
    % MSE averaged over last 10 runs must be below 0.3 AND
    % change in MSE averaged over last 10 runs is less than 0.005
    if(MSEa(1,end)<=0.3)&&(MSEd<=0.005)
        break;
    else
        % run training
        bponline %nIters = 10 (each bp call)
    end
    
end

figure(1)
plot(MSE);
title('MSE');

figure(2)
plot(gradSize);
title('gradSize');

testNetwork


