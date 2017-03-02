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
if ~helperChkDsetStruct(dataset)
    error('Dataset does not have the expected structure.')
end

% RGB histograms.
colorFeatures.rgbHistograms = extractHistograms(dataset, ...
    'NumBins', p.Results.NumBins, ...
    'NumChannels', p.Results.NumChannels);

% Compute HSV datasets (HARDCODED)
% TODO: PUT INTO A FUNCTION WITH SEVERAL COLOR SPACES
%fields = fieldnames(dataset, '-full');
%for i = 1:numel(fields)
%    inputTensor = dataset.(fields{i});
%    outputTensor = zeros(size(inputTensor,1), size(inputTensor,2), size(inputTensor,3), size(inputTensor,4));
%    for j = 1:632
%       outputTensor(:,:,:,j) = rgb2hsv(inputTensor(:,:,:,j));
%    end
%    hsvDataset.(fields{i}) = outputTensor;
%end

hsvDataset = convertColorSpaceDataset(dataset);

% HSV histograms.
colorFeatures.hsvHistograms = extractHistograms(hsvDataset, ...
    'NumBins', p.Results.NumBins, ...
    'NumChannels', p.Results.NumChannels);

end