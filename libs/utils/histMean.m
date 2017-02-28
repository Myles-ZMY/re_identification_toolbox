function mean = histMean( hist, maxCount )
%HISTMEAN Summary of this function goes here
%   Detailed explanation goes here

% TODO: DOCS/INPUTPARSER

numBins = numel(hist);
% binning
binSize = maxCount/numBins;

% TODO: CHECK SIZES
mean = 1/maxCount*sum(hist.*(binSize/2:binSize:maxCount)');

end