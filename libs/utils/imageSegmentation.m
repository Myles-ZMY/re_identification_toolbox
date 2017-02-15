function [sProbeSet, sGallerySet] = imageSegmentation(probeSet, gallerySet, varargin)

%IMAGESEGMENTATION Segments images in both a probe and a gallery set
%according to the specified mode.

% TODO: imageSegmentation should be called only on one tipe of image. Write
% a helper method, instead.
p = inputParser;
expectedFields = {'originalImages','noisyImages','flipImages', ...
    'transfImages','rotatedImages'}';
setValidationFcn = @(x) assert(isstruct(x) && ...
    isequal(fieldnames(x,'-full'),expectedFields), ...
    'Structure fields are not valid. Check documentation.');
addRequired(p, 'probeSet', setValidationFcn);
addRequired(p, 'gallerySet', setValidationFcn);
addParameter(p, 'Height', 128, @(x) assert(isinteger(x), ...
    'Height parameter must be scalar. Check documentation.'));
addParameter(p, 'Width', 48, @(x) assert(isinteger(x), ...
    'Width parameter must be scalar. Check documentation.'));
addParameter(p, 'HorizontalPatches', 1, @(x) assert(isinteger(x), ...
    'The number of horizontal patches must be an integer value.'));
addParameter(p, 'VerticalPatches', 1, @(x) assert(isinteger(x), ...
    'The number of vertical patches must be an integer value.'));

parse(p, probeSet, gallerySet, varargin{:});

% TODO: this should be modified to extract several color space, and store
% them in mat files

% Compute split vectors.
[hSplitVector,vSplitVector] = splitMatrix(p.Results.Height, ...
    p.Results.Width, ...
    p.Results.HorizontalPatches, ...
    p.Results.VerticalPatches);

sProbeSet = [];
sGallerySet = [];

% consider h stripe
for i = 1:(length(hSplitVector)-1)
    p_stripe = probeSet.originalImages(hSplitVector(i):hSplitVector(i+1),:,:,:);
    g_stripe = gallerySet.originalImages(hSplitVector(i):hSplitVector(i+1),:,:,:);
    for j = 1:length(vSplitVector)-1
        p_col = p_stripe(:,vSplitVector(j):vSplitVector(j+1),:,:);
        g_col = g_stripe(:,vSplitVector(j):vSplitVector(j+1),:,:);
        sProbeSet = cat(5,sProbeSet,p_col);
        sGallerySet = cat(5,sGallerySet,g_col);
    end
end

end