function [ output_args ] = helperImageSegmentation(probeSet, gallerySet)
%HELPERIMAGESEGMENTATION Wrapper method for image segmentation. Wraps image
%segmentations along different types of images (i.e. noisy, rotated, etc.)

p = inputParser;
probeSetName = 'ProbeSet';
gallerySetName = 'GallerySet';
setValidationFcn = @(x) assert(isstruct(x), errorString
    strcat(y, ' must be a structure.'));
addRequired(p, probeSetName, setValidationFcn(probeSet, probeSetName));
addRequired(p, gallerySetName, setValidationFcn(gallerySet, gallerySetName));
%addParameter(p, 'Height', 128, @(x) assert(isinteger(x), ...
%    'Height parameter must be scalar. Check documentation.'));
%addParameter(p, 'Width', 48, @(x) assert(isinteger(x), ...
%    'Width parameter must be scalar. Check documentation.'));
%addParameter(p, 'HorizontalPatches', 1, @(x) assert(isinteger(x), ...
%    'The number of horizontal patches must be an integer value.'));
%addParameter(p, 'VerticalPatches', 1, @(x) assert(isinteger(x), ...
%    'The number of vertical patches must be an integer value.'));

parse(p, probeSet, gallerySet);%, varargin{:});

%imageSegmentation

end

