function varargout = extractColorFeatures(segmentedProbeSet, ...
                                          segmenteGallerySet, ...
                                          varargin)
%EXTRACTCOLORFEATURES Embeds the extraction of different color features on
%the image.
%   VARARGOUT = EXTRACTHISTOGRAMS(SEGMENTEDPROBESET, SEGMENTEDGALLERYSET,
%   NUMBINS, NUMCHANNELS) returns a 

%Extracts color features in a given image. This is a
%wrapper around several different color feature extraction techniques.
%is a Summary of this function goes here
%   Detailed explanation goes here

% TODO: CHECK INPUT
p = inputParser;
structValFcn = @(x) assert(isstruct(x), 'It should be a structure.');
intValFcn = @(x) assert(isinteger(x), 'It should be an integer value.');
addRequired(p, 'SegmentedProbeSet', structValFcn);
addRequired(p, 'SegmenteGallerySet', structValFcn);
addParameter(p, 'NumBins', 10, intValFcn);
addParameter(p, 'NumChannels', 3, intValFcn);

parse(p, segmentedProbeSet, segmentedGallerySet, varargin{:});

% Extract RGB histograms.
varargout{1} = extractHistograms(segmentedProbeSet, 'NumBins', p.Results.NumBins, 'NumChannels', p.Results.NumChannels);
varargout{2} = extractHistograms(segmenteGallerySet, 'NumBins', p.Results.NumBins, 'NumChannels', p.Results.NumChannels);

end