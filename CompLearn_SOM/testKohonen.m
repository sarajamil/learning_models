% Kohonen's
% Self Organizing Map
% Model 2
clear all; close all; clc;

Initialize

W = trainKohonen(W, P, m, g, Nreps);

test = zeros(Noutputs,Npats);
for i = 1:Npats
    test(:,i) = WinnerTakeAll(W, P(:,i));
end
test

% % testing with respect to slope of neighbourhood function
% for m = 0.05:0.05:0.9
%     W = trainKohonen(W, P, m, g, Nreps);
%     test = zeros(Noutputs,Npats);
%     for i = 1:Npats
%         test(:,i) = WinnerTakeAll(W, P(:,i));
%     end
%     disp(['test for slope = ', num2str(m)]); disp(test);
% end