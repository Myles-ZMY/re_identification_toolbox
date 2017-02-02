function [probeSet, gallerySet] = imageReader(datasetDir, ...
                                                imgExt, ....
                                                height, ....
                                                width, ...
                                                channels, ...
                                                varargin)
%IMAGEREADER Reads images of a person re-identification datasets.
%   [PROBESET, GALLERYSET] = IMAGEREADER(DATASETDIR, IMGEXT, HEIGHT,
%   WIDTH, CHANNELS, VARARGIN) reads the images with extension IMGEXT
%   stored in DATASETDIR, which has a fixed structure with 'cam_a' and
%   'cam_b' in the single-shot case, or must be normalized in the
%   multi-shot case. Images are read and augmented through the
%   IMAUGMENTEDREAD function, and results are stored in two output
%   structures, PROBESET and GALLERY SET, which hold five H x W x K x N
%   tensors, where H is the height of each image, W is the width of each
%   image, K is the number of channels, and N is the cardinality of probe
%   and gallery sets.

p = inputParser;

addRequired(p, 'DatasetDir', @ischar);
addRequired(p, 'ImgExt', @ischar);
addRequired(p, 'Height', @isscalar);
addRequired(p, 'Width', @isscalar);
addRequired(p, 'Channels', @isscalar);
addParameter(p, 'MultiShot', false, @islogical);

parse(p, datasetDir, imgExt, height, width, channels, varargin{:});

% Check if the dataset is multi-shot.
if(p.Results.MultiShot)
    ExtractMultiShotGallery;
end

% Create structures for images.
pImages = dir(fullfile(p.Results.DatasetDir, 'cam_a', p.Results.ImgExt));
gImages = dir(fullfile(p.Results.DatasetDir, 'cam_b', p.Results.ImgExt));

% Check if the probe set and the gallery set have the same number of
% images.
if length(pImages)==length(gImages)
    imgNumber = length(pImages);
else
    error('The probe set and the gallery set must have the same number of images');
end

% Create tensors.
pTensor = zeros(p.Results.Height, p.Results.Width,p.Results.Channels,imgNumber);
gTensor = zeros(p.Results.Height, p.Results.Width,p.Results.Channels,imgNumber);
pNoiseTensor = pTensor;
gNoiseTensor = gTensor;
pFlipTensor = pTensor;
gFlipTensor = gTensor;
pTransfTensor = pTensor;
gTransfTensor = gTensor;
pRotTensor = pTensor;
gRotTensor = gTensor;

% Read images and store them in tensors.
parfor i = 1:imgNumber
    [pTensor(:,:,:,i), pNoiseTensor(:,:,:,i), pFlipTensor(:,:,:,i), pTransfTensor(:,:,:,i), pRotTensor(:,:,:,i)] = imAugmentedRead(fullfile(pImages(i).folder,pImages(i).name));
    [gTensor(:,:,:,i), gNoiseTensor(:,:,:,i), gFlipTensor(:,:,:,i), gTransfTensor(:,:,:,i), gRotTensor(:,:,:,i)] = imAugmentedRead(fullfile(gImages(i).folder,gImages(i).name));
end

% Store tensors in output structs.
probeSet.originalImages = pTensor;
probeSet.noisyImages = pNoiseTensor;
probeSet.flipImages = pFlipTensor;
probeSet.transfImages = pTransfTensor;
probeSet.rotatedImages = pRotTensor;
gallerySet.originalImages = gTensor;
gallerySet.noisyImages = gNoiseTensor;
gallerySet.flipImages = gFlipTensor;
gallerySet.transfImages = gTransfTensor;
gallerySet.rotatedImages = gRotTensor;

end