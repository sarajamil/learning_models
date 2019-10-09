function visualizeSample3(in_x)
% SORRY I MODIFIED IT AGAIN...
% 
% This one plots all the hidden units' weights
% at the same time (as an image)
% 
% Example: visualizeSample(hiddenWeights)

for k = 1:size(in_x,1)
    x = in_x(k,1:784);
    
    [Nsamples,Npixels] = size(x);

    % Convert the sample into its original 2D form
    x = reshape(x,sqrt(Npixels),sqrt(Npixels));

    % Display the image
    figure(1)
    subplot(4,5,k);
    imshow(x);
end

end
