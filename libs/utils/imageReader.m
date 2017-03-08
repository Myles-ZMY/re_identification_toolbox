function dataset = imageReader(datasetDir, imgExt, varargin)
%IMAGEREADER Reads images from a re-id dataset.

%   TODO: DOCS                                            
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
% TODO: IMRESIZE
addParameter(p, 'Height', 128, scalarValFcn);
addParameter(p, 'Width', 48, scalarValFcn);
addParameter(p, 'Channels', 3, scalarValFcn);
addParameter(p, 'MultiShot', false, logicalValFcn);

parse(p, datasetDir, imgExt, varargin{:});

% Check if the dataset is multi-shot.
if(p.Results.MultiShot)
    % TODO
    extractMultiShotGallery;
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
probeSet = uint8(zeros(p.Results.Height, ...
    p.Results.Width, ...
    p.Results.Channels, ...
    imgNumber));
gallerySet = probeSet;

% Read images and store them in tensors.
parfor i = 1:imgNumber
    probeSet(:,:,:,i) = imread(fullfile(probe(i).folder, probe(i).name));
    gallerySet(:,:,:,i) = imread(fullfile(gallery(i).folder,gallery(i).name));
end

dataset.probeSet = probeSet;
dataset.gallerySet = gallerySet;

end