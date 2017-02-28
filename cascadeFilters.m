function surrogateImages = cascadeFilters( imageMat, varargin )
%CASCADEFILTERS Summary of this function goes here
%   Detailed explanation goes here

p = inputParser;
allowedFilterTypes = {'gaussian', 'median'};
addRequired(p, 'ImageMat', ...
    @(x) assert(ismatrix(x), 'It must be a H x W x K matrix.'));
addParameter(p, 'LowPassIteration', 3, ...
    @(x) assert(isinteger(x), 'It must be an integer.'));
addParameter(p, 'FilterType', 'gaussian', ...
    @(x) assert(any(validatestring(x, allowedFilterTypes), ...
        'It must be an allowed filter type.')));

parse(p, imageMat, varargin{:});

% Iterate low pass filtering until LowPassIteration limit is reached.
for i = 1:p.Results.LowPassIteration
    % Iterate on each channel of the image, then extract histogram.
    for k = 1:size(imageMat, 3)
        switch p.Results.FilterType
            case 'gaussian'
                filteredChannel = imgaussfilt(imageMat(:,:,k));
            case 'median'
                filteredChannel = medfilt2(imageMat(:,:,k));
        end
        % hist_ten(:,k,i,j) = histcounts(filteredChannel,p.Results.NumBins,'Normalization','probability');
    end
end