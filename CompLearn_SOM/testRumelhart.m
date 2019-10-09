% Rumelhart & Zipser's
% Competitive Learning Model
% Model 1
clear all; close all; clc;

Initialize

W = trainRumelhart(W, P, g, Nreps);

% to test an input, use WinnerTakeAll
for i = 1:Npats
    test(:,i) = WinnerTakeAll(W, P(:,i));
end
test