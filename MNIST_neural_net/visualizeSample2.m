function visualizeSample2(in_x,in_y,sample)
% SORRY I MODIFIED THIS FUNCTION
% 
% Modified function can plot 8 samples 
% from the MNIST dataset at the same time
% 
% Example: visualizeSample(train_x,train_y,1:8) 

for k = 1:length(sample)
    x = in_x(:,sample(k));
    x = x'; %modified because of transpose in bpinit

    [Nsamples,Npixels] = size(x);

    % Convert the sample into its original 2D form
    x = reshape(x,sqrt(Npixels),sqrt(Npixels));

    % for displaying the correct category
    y = in_y(:,sample(k));
    [n,i] = max(y);

    % Display the image with target as title
    figure(1)
    subplot(2,4,k);
    imshow(x'); %another transpose...
    title(num2str(i-1));
    hold on
end

end
