function visualizeSample(x)
% Displays a single MNIST data sample
% Example: visualizeSample(trainX(10,:))

[Nsamples,Npixels] = size(x);

if Nsamples > 1
    warning('Only displaying the first sample provided')
    x = x(1,:);
end

% Convert the sample into its original 2D form
x = reshape(x,sqrt(Npixels),sqrt(Npixels));

% Display the image
imshow(x);