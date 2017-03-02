function mean = histMean( histogram, varargin )
%HISTMEAN Summary of this function goes here
%   Detailed explanation goes here

p = inputParser;
addRequired(p, 'Histogram', ...
    @(x) assert(isnumeric(x), 'It must be a tensor.'));
addParameter(p, 'MaxCount', 256, ...
    @(x) assert(isscalar(x), 'It must be a scalar.'));

parse(p, histogram, varargin{:});

% Evaluate the shape of the histogram.

% Force parameters -> histogram must be a column vector, and maxCount an
% integer.
maxCount = floor(p.Results.MaxCount);
%histogram = histogram(:);

% Evaluate space between bins.
binSize = maxCount/size(histogram,1);

% Weighted probabilities.
wProb = binSize/2:binSize:maxCount;

% Compute weighted mean.
mean = 1/maxCount*sum(histogram.*wProb');

end