% Preliminary setup
clear; close all; clc;

% Loading the data
load FinalProjectData

% Add the FBCSP folder to the path
addpath FBCSP

% Get some informatino about data size
nSubj = length(unique(SubjectID));  % Number of Subjects
nTrials = length(Y);                % Total number of trials

% Example: If you want to compute how many trials belong to Participant 5,
% you could use 'nTrials_p5 = sum(SubjectID==5);

% Options for FBCSP
opt.features.cspcomps = 2;      % This is K from the lecture slides (you should have 2*K features per filter in the filter bank)
opt.features.cspband = [4,32];  % The filter bank will be constructed within this frequency range
opt.features.cspstep = 2;       % Adjacent filters will having initial frequency shifted by 2 Hz
opt.features.cspwidth = 4;      % Each bandpass filter will cover a 4 Hz band
opt.mode = 'concat';            % CSP can actually be computed according to about 4 mathematically equivalent formulations. I've selected one for you to use here.
opt.filter.type = 'butter';     % The filter bank will be constructed of Butterworth bandpass filters
opt.filter.order = 2;           % Each filter will be second-order
opt.filter.sr = 220;            % This is just the sampling rate of the EEG signal (needed to compute the coefficients of each bandpass filters)
