function [probe_dataset, gallery_dataset] = ImageReader(dataset_dir, ...
                                            image_extension, pars)
%IMAGEREADER Organize the images of a person re-identification dataset in
%two tensors with a specific structure.
%   DATASET = IMAGEREADER(DATASET_DIR, IMAGE_EXTENSION, PARS) reads the
%   images with extension IMAGE_EXTENSION stored in the subfolders of 
%   DATASET_DIR, which are assumed to be 'cam_a' and 'cam_b', and
%   represents the probe and the gallery sets, respectively. Images are
%   stored in a H x W x K x N tensor, where H is the height of the image, 
%   W is the width of the image, K is the number of channels, and N is the 
%   cardinality of both the probe and the gallery set. The values of H, W 
%   and K are determined by the PARS structure.

    % Check inputs.
    if nargin~=3
        error('The number of input arguments is not correct.');
    elseif ~isstruct(pars)
        error('The parameters must be a structure.')
    elseif ~((isfield(pars,'height'))...
            &&(isfield(pars,'width'))...
            &&(isfield(pars,'channels')))
        error('Check pars structure')
    elseif ~exist(dataset_dir,'dir')
        error('Dataset Dir does not exist, or the path is not correct')
    end
    % Check if the dataset is multi-shot.
    if(pars.multi_shot)
        ExtractMultiShotGallery;
    end
    % Create structures for images.
    probe_images = dir(fullfile(dataset_dir, 'cam_a', image_extension));
    gallery_images = dir(fullfile(dataset_dir, 'cam_b', image_extension));
    % Check if the probe set and the gallery set have the same number of
    % images.
    if length(probe_images)==length(gallery_images)
        dataset_size = length(probe_images);
    else
        error('The probe set and the gallery set must have the same number of images');
    end
    % Create tensors.
    probe_dataset = zeros(pars.height,pars.width,pars.channels,dataset_size);
    gallery_dataset = zeros(pars.height,pars.width,pars.channels,dataset_size);
    % Read images and store them in tensors.
    parfor i = 1:dataset_size
        probe_dataset(:,:,:,i) = imread(probe_images(i));
        gallery_dataset(:,:,:,i) = imread(gallery_images(i));
    end
end