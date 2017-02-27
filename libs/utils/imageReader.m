function [probeSet, gallerySet] = imageReader(datasetDir, ...
                                                imgExt, ....
                                                height, ....
                                                width, ...
                                                channels, ...
                                                varargin)
%IMAGEREADER Reads images from a re-id dataset.
                                            
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

charValFcn = @(x) assert(ischar(x), 'It must be a string value.');
scalarValFcn = @(x) assert(isscalar(x), 'It must be a scalar value.');
logicalValFcn = @(x) assert(islogical(x), 'It must be a logical value.');
addRequired(p, 'DatasetDir', charValFcn);
addRequired(p, 'ImgExt', charValFcn);
addRequired(p, 'Height', scalarValFcn);
addRequired(p, 'Width', scalarValFcn);
addRequired(p, 'Channels', scalarValFcn);
addParameter(p, 'MultiShot', false, logicalValFcn);
addParameter(p, 'GetHsv', false, logicalValFcn);

parse(p, datasetDir, imgExt, height, width, channels, varargin{:});

getHsv = p.Results.GetHsv;

% Check if the dataset is multi-shot.
if(p.Results.MultiShot)
    ExtractMultiShotGallery;
end

% Create structures for images.
probe = dir(fullfile(p.Results.DatasetDir, 'cam_a', p.Results.ImgExt));
gallery = dir(fullfile(p.Results.DatasetDir, 'cam_b', p.Results.ImgExt));

% Check if the probe set and the gallery set have the same number of
% images.
if length(probe)==length(gallery)
    imgNumber = length(probe);
else
    error('The probe set and the gallery set must have the same number of images');
end

% Create tensors.
probeImages = zeros(p.Results.Height, p.Results.Width,p.Results.Channels,imgNumber);
galleryImages = zeros(p.Results.Height, p.Results.Width,p.Results.Channels,imgNumber);
%pNoiseTensor = pTensor;
%gNoiseTensor = gTensor;
%pFlipTensor = pTensor;
%gFlipTensor = gTensor;
%TransfTensor = pTensor;
%gTransfTensor = gTensor;
% TODO: OPTIMIZE SIZES
%pRotTensor = zeros(p.Results.Height, p.Results.Width*2, p.Results.Channels, imgNumber);
%gRotTensor = pRotTensor;


if getHsv
    probeImagesHsv = zeros(p.Results.Height, p.Results.Width,p.Results.Channels,imgNumber);
    galleryImagesHsv = zeros(p.Results.Height, p.Results.Width,p.Results.Channels,imgNumber);
end

% Read images and store them in tensors.
parfor i = 1:imgNumber
    currProbe = fullfile(probe(i).folder,probe(i).name);
    currGallery = fullfile(gallery(i).folder,gallery(i).name);
    probeImages(:,:,:,i) = imread(currProbe);
    galleryImages(:,:,:,i) = imread(currGallery);
    if getHsv
        probeImagesHsv(:,:,:,i) = rgb2hsv(probeImages(:,:,:,i));
        galleryImagesHsv(:,:,:,i) = rgb2hsv(galleryImages(:,:,:,i));
    end
%    [pTensor(:,:,:,i), pNoiseTensor(:,:,:,i), pFlipTensor(:,:,:,i), pTransfTensor(:,:,:,i)] = imAugmentedRead(currProbe, 'IsHsv', isHsv);
%    [gTensor(:,:,:,i), gNoiseTensor(:,:,:,i), gFlipTensor(:,:,:,i), gTransfTensor(:,:,:,i)] = imAugmentedRead(currGImage, 'IsHsv', isHsv);
end

probeSet.rgb = probeImages;
gallerySet.rgb = galleryImages;
if getHsv
    probeSet.hsv = probeImagesHsv;
    gallerySet.hsv = galleryImagesHsv;
end
% Store tensors in output structs.
%probeSet.originalImages = pTensor;
%probeSet.noisyImages = pNoiseTensor;
%probeSet.flipImages = pFlipTensor;
%probeSet.transfImages = pTransfTensor;
%probeSet.rotatedImages = pRotTensor;
%gallerySet.originalImages = gTensor;
%gallerySet.noisyImages = gNoiseTensor;
%gallerySet.flipImages = gFlipTensor;
%gallerySet.transfImages = gTransfTensor;
%gallerySet.rotatedImages = gRotTensor;

end