% display training patterns 

sumGenres = [...
    sum(trainingPatterns(1:3,:))', ...
    sum(trainingPatterns(4:6,:))', ...
    sum(trainingPatterns(7:9,:))', ...
    sum(trainingPatterns(10:12,:))'];


avgGroups = [...
    sum(sumGenres(1:7,:))./7;
    sum(sumGenres(8:14,:))./7;
    sum(sumGenres(15:21,:))./7;
    sum(sumGenres(22:28,:))./7];

% for all examples
fprintf('Example\tSci-fi\tComedy\tHorror\tDrama\n');
for i = 1:28
    fprintf('%d\t\t%d\t\t%d\t\t%d\t\t%d\n', [i, sumGenres(i,:)]);
end

% for all groups
fprintf('Group\tSci-fi\t\tComedy\t\tHorror\t\tDrama\n');
for i = 1:4
    fprintf('%i\t\t%f\t%f\t%f\t%f\n', [i, avgGroups(i,:)]);
end
