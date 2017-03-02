function segmDataset = imageSegmentation(dataset, varargin)
% TODO: DOCUMENTATION
%IMAGESEGMENTATION Segments images in both a probe and a gallery set
%according to the specified mode.

p = inputParser;
setValFcn = @(x) assert(isstruct(x), 'It should be a structure.');
intValFcn = @(x) assert(isinteger(x), 'It should be an integer value.');

addRequired(p, 'Dataset', setValFcn);
addParameter(p, 'HorizontalPatches', 1, intValFcn);
addParameter(p, 'VerticalPatches', 1, intValFcn);

parse(p, dataset, varargin{:});

% Check dataset structure.
if ~helperChkDsetStruct(p.Results.Dataset)
    error('Dataset does not have the expected structure.')
end

height = size(p.Results.Dataset.probeSet,1);
width = size(p.Results.Dataset.probeSet,2);

% Compute split vectors.
[hSplitVector,vSplitVector] = helperSplitMatrix(height, ...
                                                width, ...
                                                p.Results.HorizontalPatches, ...
                                                p.Results.VerticalPatches);

sProbeSet = [];
sGallerySet = [];

% consider h stripe
for i = 1:(length(hSplitVector)-1)
    probeStripe = dataset.probeSet(hSplitVector(i):hSplitVector(i+1),:,:,:);
    galleryStripe = dataset.gallerySet(hSplitVector(i):hSplitVector(i+1),:,:,:);
    for j = 1:length(vSplitVector)-1
        probeCol = probeStripe(:,vSplitVector(j):vSplitVector(j+1),:,:);
        galleryCol = galleryStripe(:,vSplitVector(j):vSplitVector(j+1),:,:);
        sProbeSet = cat(5, sProbeSet, probeCol);
        sGallerySet = cat(5, sGallerySet, galleryCol);
    end
end


function [hSplit,vSplit] = helperSplitMatrix(height, ...
                                             width, ...
                                             numHeight, ...
                                             numWidth)
    hStep = floor(height/numHeight);
    vStep = floor(width/numWidth);
    hSplit = [1 hStep:hStep:height];
    vSplit = [1 vStep:vStep:width];
end

segmDataset.probeSet = sProbeSet;
segmDataset.gallerySet = sGallerySet;

end