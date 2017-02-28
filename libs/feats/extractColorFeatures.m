function colorFeatures = extractColorFeatures(dataset, varargin)
%EXTRACTCOLORFEATURES Embeds the extraction of different color features on
%the image.
%   VARARGOUT = EXTRACTHISTOGRAMS(SEGMENTEDPROBESET, SEGMENTEDGALLERYSET,
%   NUMBINS, NUMCHANNELS) returns a 

%Extracts color features in a given image. This is a
%wrapper around several different color feature extraction techniques.
%is a Summary of this function goes here
%   Detailed explanation goes here

p = inputParser;
structValFcn = @(x) assert(isstruct(x), 'It should be a structure.');
intValFcn = @(x) assert(isnumeric(x), 'It should be an integer value.');

addRequired(p, 'SegmDataset', structValFcn);
addParameter(p, 'NumBins', 10, intValFcn);
addParameter(p, 'NumChannels', 3, intValFcn);

parse(p, dataset, varargin{:});

% Check dataset structure.
if ~helperChkDsetStruct(dataset, {'probeSet','gallerySet'}')
    error('Dataset does not have the expected structure.')
end

% Histogram.
colorFeatures.histograms = extractHistograms(dataset, ...
    'NumBins', p.Results.NumBins, ...
    'NumChannels', p.Results.NumChannels);

% TODO: OTHER COLOR FEATURES

end