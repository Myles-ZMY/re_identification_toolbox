CountLabel = imds.countEachLabel;

trainingNumFiles = round(length(imds.Files)*0.7);

rng(1)

[trainData, testData] = splitEachLabel(imds,1);%, ...
%    trainingNumFiles, 'randomize');

%network
img = readimage(imds,1);
sizeInputLayer = size(img);

layers = [imageInputLayer(sizeInputLayer)
    convolution2dLayer(5,20)
    reluLayer
    maxPooling2dLayer(2,'Stride',2)
    convolution2dLayer(5,20)
    reluLayer
    maxPooling2dLayer(2,'Stride',2)
    fullyConnectedLayer(632)
    softmaxLayer
    classificationLayer()];

options = trainingOptions('sgdm', 'MaxEpochs', 15, ...
    'InitialLearnRate', 0.0001);

convnet = trainNetwork(trainData, layers, options);