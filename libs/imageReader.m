function [p_set, g_set, image_no] = imageReader(dataset_dir, ...
    img_ext, height, width, channels, varargin)
%IMAGEREADER Organizes the images of a person re-identification dataset in
%two tensors with a specific structure.
% RIVEDI DOCS
%   [P_SET, G_SET] = IMAGEREADER(DATASET_DIR, IMAGE_EXTENSION, PARS) reads the
%   images with extension IMAGE_EXTENSION stored in the subfolders of 
%   DATASET_DIR, which are assumed to be 'cam_a' and 'cam_b', and
%   represents the probe and the gallery sets, respectively. Images are
%   stored in a H x W x K x N tensor, where H is the height of the image, 
%   W is the width of the image, K is the number of channels, and N is the 
%   cardinality of both the probe and the gallery set. The values of H, W 
%   and K are determined by the PARS structure.

% TODO: INPUTPARSER

p = inputParser;

addRequired(p, 'DatasetDir', @ischar);
addRequired(p, 'ImgExt', @ischar);
addRequired(p, 'Height', @isscalar);
addRequired(p, 'Width', @isscalar);
addRequired(p, 'Channels', @isscalar);
addParameter(p, 'MultiShot', false, @islogical);

parse(p, dataset_dir, img_ext, height, width, channels, varargin{:});

% Check if the dataset is multi-shot.
if(p.Results.MultiShot)
    ExtractMultiShotGallery;
end
% Create structures for images.
probe_images = dir(fullfile(p.Results.DatasetDir, 'cam_a', ...
    p.Results.ImgExt));
gallery_images = dir(fullfile(p.Results.DatasetDir, 'cam_b', ...
    p.Results.ImgExt));
% Check if the probe set and the gallery set have the same number of
% images.
if length(probe_images)==length(gallery_images)
    image_no = length(probe_images);
else
    error('The probe set and the gallery set must have the same number of images');
end
% Create tensors.
p_set = zeros(p.Results.Height,p.Results.Width,p.Results.Channels,image_no);
g_set = zeros(p.Results.Height,p.Results.Width,p.Results.Channels,image_no);
% Read images and store them in tensors.
parfor i = 1:image_no
    [p_set(:,:,:,i),~,~,~,~] = imAugmentedRead(fullfile(probe_images(i).folder,probe_images(i).name));
    [g_set(:,:,:,i),~,~,~,~] = imAugmentedRead(fullfile(gallery_images(i).folder,gallery_images(i).name));
end

end