function dataset = ImageReader(dataset_name, dataset_folder, varargin)
%IMAGEREADER Organize the images of a person re-identification dataset in a
%tensor with a specific structure.
%   DATASET = IMAGEREADER(DATASET_NAME, DATASET_FOLDER) reads each image in
%   the DATASET_FOLDER, and store it in a H x W x K x N tensor, where H is
%   the height of the image, W is the width of the image, K is the number
%   of channels, and N is the cardinality of the DATASET_NAME dataset (i.e.
%   the sum of the cardinality of both the gallery and the probe sets).
%   
%   DATASET = IMAGEREADER(DATASET_NAME, DATASET_FOLDER, NORMALIZE_IMGS, 
%   HEIGHT, WIDTH) also, if NORMALIZE_IMGS is true, normalizes images to
%   H = HEIGHT and W = WIDTH.
%
%   DATASET = IMAGEREADER(DATASET_NAME, DATASET_FOLDER, NEW_COLOR_SPACE)
%   converts images in the color space specified by NEW_COLOR_SPACE.
%   Current supported color spaces are RGB (default) and HSV.

% TODO 1: CHECK


end

