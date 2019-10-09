%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Here's your starter code for your final project. Fill in the sections
% indicated by the comments. Make sure I can check all of your results by
% running this m-file. 
%
% Good luck!
% Kiret
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 
% % PSYCH/CSE 734 Project
% % Sara Jamil
% % 
% % Please run the code one section at a time
% % 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% TASK 1: LOO subject classification
fprintf('\n---------------\nTask 1: LOO Subject Classification\n---------------\n');

prelimSetup % Preliminary Setup

% Some arrays in which to store data
Accuracy = zeros(nSubj,3);  % The classification accuracy for each subject
elt = zeros(nSubj,3);   % Computation time for training

for i = 1:nSubj
    fprintf('Obtaining Results for Participant %d/%d\n',i,nSubj);
    
    % Partition training and test set so the test set is all the trials for
    % participant i and the training set is all trials for the other
    % participants put together
    trainidx = SubjectID~=i;
    testidx = SubjectID==i;
    
    % Compute FBCSP features (see 'help FBCSPfeatures' for details on
    % inputs and outputs). FBCSPfeatures.m is already set up to construct
    % the CSP filters using only the training data and to give you the
    % features for the training data and the test data together.
    [EEGcsp,Features,cspftrs,Psel] = FBCSPfeatures(EEG,Y,trainidx,opt);
    
    % For input into SVMTRAIN
    Features_train = Features(:,trainidx)';
    Features_test = Features(:,testidx)';
    Y_train = Y(1,trainidx)';
    Y_test = Y(1,testidx)';
    
    % If you wish to use feature selection, that should go here
        
    % Classification - put your classifier here (get Yhat from your
    % classifier). If your classifier instead just outputs a classification
    % accuracy, you can remove the variables 'Yhat' and 'Correct' and fill
    % the elements of Accuracy directly from your classifier function
    
    % Training SVM Classifiers
    tic;
    model1 = svmtrain(Features_train,Y_train,'kernel_function','rbf','method','SMO');
    elt(i,1) = toc;
    tic;
    model2 = fitcsvm(Features_train,Y_train,'KernelFunction','gaussian','Solver','SMO','Verbose',0,'CrossVal','off');
    elt(i,2) = toc;
    
    % Training neural network
    net = feedforwardnet(10,'traingd');
    net.divideParam.trainRatio = 1;
    net.divideParam.valRatio = 0;
    net.divideParam.testRatio = 0;
    net.trainParam.epochs = 10000;
    net.trainParam.showWindow = 0;
    tic;
    [net,tr] = train(net,Features_train',Y_train');
    elt(i,3) = toc;
    
    
    % Compile results
    C1 = svmclassify(model1,Features_test);
    acc1 = Y_test==C1;  % number of correct classifications
    Accuracy(i,1) = 100*(mean(acc1));     % Plug in the accuracy you get from your classifier here
    C2 = predict(model2,Features_test);
    acc2 = Y_test==C2;
    Accuracy(i,2) = 100*(mean(acc2));
    C3 = net(Features_test');
    C3(C3>=0.5) = 1; C3(C3<0.5) = 0; C3 = C3';
    acc3 = Y_test==C3;
    Accuracy(i,3) = 100*(mean(acc3));
    
    fprintf('----MODEL 1 Accuracy: %3.2f %%\n',Accuracy(i,1)); % You could display your accuracy here in case you want to see it as the code runs
    fprintf('----MODEL 2 Accuracy: %3.2f %%\n',Accuracy(i,2)); % You could display your accuracy here in case you want to see it as the code runs
    fprintf('----MODEL 3 Accuracy: %3.2f %%\n',Accuracy(i,3)); % You could display your accuracy here in case you want to see it as the code runs
end

% Compute the mean and std accuracy across all participants
Task1_meanAccuracy = mean(Accuracy);
Task1_stdAccuracy = std(Accuracy);

fprintf('-----\n TASK 1 MODEL 1 ACCURACY: %3.2f %% (%g)\n-----\n',Task1_meanAccuracy(1),Task1_stdAccuracy(1));
fprintf('-----\n TASK 1 MODEL 2 ACCURACY: %3.2f %% (%g)\n-----\n',Task1_meanAccuracy(2),Task1_stdAccuracy(2));
fprintf('-----\n TASK 1 MODEL 3 ACCURACY: %3.2f %% (%g)\n-----\n',Task1_meanAccuracy(3),Task1_stdAccuracy(3));

%% TASK 2: Within-Subject Classification
fprintf('\n---------------\nTask 2: Within-Subject Classification\n---------------\n');

prelimSetup % Preliminary Setup

Accuracy = [];  % The classification accuracy for each subject

for i = 1:nSubj
    fprintf('Obtaining Results for Participant %d/%d\n',i,nSubj);
    
    % Choosing the participant to obtain training and test data
    partidx = SubjectID==i;
    nTrials_p = sum(partidx);
    EEGp = EEG(1,partidx);
    Yp = Y(1,partidx);
    tempidx = true(1,nTrials_p);
    
    if (length(unique(Yp))<2)
        % Don't train on this participant
        % because all of the EEG data belongs to one of the two classes
        fprintf('----Skipping this participant\n');
    else
        % Compute FBCSP features for training and test data
        % of participant i
        [EEGcsp,Features,cspftrs,Psel] = FBCSPfeatures(EEGp,Yp,tempidx,opt);

        acc = [];

        for j = 1:nTrials_p
            % Creating training and test indices
            t = tempidx; t(j) = false; 
            trainidx = t;
            testidx = ~t;

            % For input into SVMTRAIN
            Features_train = Features(:,trainidx)';
            Features_test = Features(:,testidx)';
            Y_train = Yp(1,trainidx)';
            Y_test = Yp(1,testidx)';

            if (length(unique(Y_train))<2)
                % Don't train on this trial
                % because training set contains only one class
            else
                % Classification
                model = svmtrain(Features_train,Y_train,'kernel_function','rbf','method','SMO');

                % Compile results for each test
                C = svmclassify(model,Features_test);
                acc = [acc; Y_test==C];
            end
        end
        
        % Compile results
        Accuracy = [Accuracy; i, 100*mean(acc)]; %include participant #
        fprintf('----Accuracy: %3.2f %%\n',Accuracy(end));
    end
    
end

% Compute the mean and std accuracy across all participants
Task2_meanAccuracy = mean(Accuracy);
Task2_stdAccuracy = std(Accuracy);

fprintf('-----\n TASK 2 ACCURACY: %3.2f %% (%g)\n-----\n',Task2_meanAccuracy(2),Task2_stdAccuracy(2));

%% TASK 3: Subject-Irrespective Classification
fprintf('\n---------------\nTask 3: Subject-Irrsepective Classification\n---------------\n');

prelimSetup % Preliminary Setup

%%%% K-fold cross-validation
fprintf('\n----- K-fold cross-validation \n \n');

% Choosing the training and testing data
% 10-fold cross-validation
CVO = cvpartition(Y','Kfold',10);

% Compute all FBCSP features for training and test data
tempidx = true(1,nTrials); %precompute features (all data)
[EEGcsp,Features,cspftrs,Psel] = FBCSPfeatures(EEG,Y,tempidx,opt);

Accuracy = zeros(CVO.NumTestSets,1);  % The classification accuracy for each partition

for i = 1:CVO.NumTestSets
    fprintf('Obtaining Results for K-fold partition %d/%d\n',i,CVO.NumTestSets);
    % For input into SVMTRAIN
    trainidx = CVO.training(i);
    testidx = CVO.test(i);

    Features_train = Features(:,trainidx)';
    Features_test = Features(:,testidx)';
    Y_train = Y(1,trainidx)';
    Y_test = Y(1,testidx)';

    % Classification
    model1 = svmtrain(Features_train,Y_train,'kernel_function','rbf','method','SMO');
%     % Testing a second model (not necessary)
%     model2 = fitcsvm(Features_train,Y_train,'KernelFunction','gaussian','Solver','SMO','Verbose',0,'CrossVal','off');
    
    % Compile results for each test
    C1 = svmclassify(model1,Features_test);
    acc1 = Y_test==C1;
    Accuracy(i,1) = 100*mean(acc1);
%     C2 = predict(model2,Features_test);
%     acc2 = Y_test==C2;
%     Accuracy(i,2) = 100*mean(acc2);
    
    fprintf('----Accuracy: %3.2f %%\n',Accuracy(i,1));
%     fprintf('----Accuracy: %3.2f %%\n',Accuracy(i,2));
end

% Compute the mean and std accuracy across all participants
Task3_meanAccuracy = mean(Accuracy);
Task3_stdAccuracy = std(Accuracy);

fprintf('-----\n TASK 3 MODEL 1 ACCURACY: %3.2f %% (%g)\n-----\n',Task3_meanAccuracy(1),Task3_stdAccuracy(1));
% fprintf('-----\n TASK 3 MODEL 2 ACCURACY: %3.2f %% (%g)\n-----\n',Task3_meanAccuracy(2),Task3_stdAccuracy(2));


%% TASK 3: Subject-Irrespective Classification
fprintf('\n---------------\nTask 3: Subject-Irrsepective Classification\n---------------\n');

prelimSetup % Preliminary Setup

%%%% Stochastic cross-validation
fprintf('\n ----- Stochastic cross-validation \n \n');

% Compute all FBCSP features for training and test data
tempidx = true(1,nTrials);
[EEGcsp,Features,cspftrs,Psel] = FBCSPfeatures(EEG,Y,tempidx,opt);

nTests = 20; % Number of tests for stochastic cv

Accuracy = zeros(nTests,1);  % The classification accuracy for each partition

for i = 1:nTests
    fprintf('Obtaining Results for Holdout test %d/%d\n',i,nTests);
    
    % Choosing the training and testing data
    % Stochastic/Holdout cross-validation on 10% of the data
    CVO = cvpartition(Y','Holdout',0.1);

    % For input into SVMTRAIN
    trainidx = CVO.training;
    testidx = CVO.test;

    Features_train = Features(:,trainidx)';
    Features_test = Features(:,testidx)';
    Y_train = Y(1,trainidx)';
    Y_test = Y(1,testidx)';

    % Classification
    model1 = svmtrain(Features_train,Y_train,'kernel_function','rbf','method','SMO');
%     % Testing a second model (not necessary)
%     model2 = fitcsvm(Features_train,Y_train,'KernelFunction','gaussian','Solver','SMO','Verbose',0,'CrossVal','off');
    
    % Compile results for each test
    C1 = svmclassify(model1,Features_test);
    acc1 = Y_test==C1;
    Accuracy(i,1) = 100*mean(acc1);
%     C2 = predict(model2,Features_test);
%     acc2 = Y_test==C2;
%     Accuracy(i,2) = 100*mean(acc2);
    
    fprintf('----Accuracy: %3.2f %%\n',Accuracy(i,1));
%     fprintf('----Accuracy: %3.2f %%\n',Accuracy(i,2));

end

Task3_meanAccuracy = mean(Accuracy);
Task3_stdAccuracy = std(Accuracy);

fprintf('-----\n TASK 3 MODEL 1 ACCURACY: %3.2f %% (%g)\n-----\n',Task3_meanAccuracy(1),Task3_stdAccuracy(1));
% fprintf('-----\n TASK 3 MODEL 2 ACCURACY: %3.2f %% (%g)\n-----\n',Task3_meanAccuracy(2),Task3_stdAccuracy(2));



