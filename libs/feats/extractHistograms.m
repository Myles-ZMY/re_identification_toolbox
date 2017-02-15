function hist_ten = extractHistograms(dataset,varargin)
%EXTRACTHISTOGRAM Extract histograms of images contained in a dataset.
%   HIST_MAT = EXTRACTHISTOGRAM(DSET,NBINS,NCHANNELS) returns a BxCxDxS
%   tensor, where:
%   - N is the number of bins (NBINS);
%   - C is the number of channels (NCHANNELS);
%   - D is the number of images in the dataset;
%   - S is the number of segments in which each image of the dataset is
%   splitted.
p = inputParser;

addRequired(p,'dataset',@(x) assert(isnumeric(x), ...
    'Dataset must a tensor'));
addParameter(p, 'NumBins', 10, @(x) assert(isscalar(x) && (x > 0) && ...
    (x < 257), 'The number of bins must be an integer between 1 and 256.'));
addParameter(p,'NumChannels', 3, @(x) assert(isscalar(x) && (x > 1) && ...
    (x < 4), 'The number of channels must be an integer between 1 and 3.'));

parse(p, dataset, varargin{:});

% Preallocate hist_ten tensor.
hist_ten = zeros(p.Results.NumBins, ...
    p.Results.NumChannels, size(dataset,4), size(dataset,5));
% Extract the histogram of the specified channels with the specific number
% of bins.
% TODO: PARFOR/GPU
for i = 1:size(dataset,4)
    for j = 1:size(dataset,5)
        for k = 1:p.Results.NumChannels
            hist_ten(:,k,i,j) = histcounts(dataset(:,:,k,i,j),p.Results.NumBins,'Normalization','probability');
        end
    end
end

end