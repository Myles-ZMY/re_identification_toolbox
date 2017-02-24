function [sProbeSet, sGallerySet] = imageSegmentation(probeSet, gallerySet, varargin)

%IMAGESEGMENTATION Segments images in both a probe and a gallery set
%according to the specified mode.

% TODO: update names; add controls to hpatches e vpatches
p = inputParser;
setValidationFcn = @(x) assert(isnumeric(x), ...
                               'It should be a numeric array.');
addRequired(p, 'probeSet', setValidationFcn);
addRequired(p, 'gallerySet', setValidationFcn);
addParameter(p, 'Height', 128, @(x) assert(isinteger(x), ...
                               'It should be an integer value'));
addParameter(p, 'Width', 48, @(x) assert(isinteger(x), ...
                               'It should be an integer value'));
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
    probeStripe = probeSet(hSplitVector(i):hSplitVector(i+1),:,:,:);
    galleryStripe = gallerySet(hSplitVector(i):hSplitVector(i+1),:,:,:);
    for j = 1:length(vSplitVector)-1
        probeCol = probeStripe(:,vSplitVector(j):vSplitVector(j+1),:,:);
        galleryCol = galleryStripe(:,vSplitVector(j):vSplitVector(j+1),:,:);
        sProbeSet = cat(5, sProbeSet, probeCol);
        sGallerySet = cat(5, sGallerySet, galleryCol);
    end
end

end