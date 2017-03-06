function filteredImg = cascadeFilterSurrogates(image, varargin)
%CASCADEFILTERSURROGATES Generates a series of low-pass filtered images.
%   FILTEREDIMG = CASCADEFILTERSURROGATES(IMAGE, VARARGIN) generates a
%   series of low-pass filtered version of the image, which are embedded in
%   the structure FILTEREDIMG.
%   Example usage:
%
%   FILTEREDIMG = CASCADEFILTERSURROGATES(IMAGEMAT) applies three cascade
%   gaussian low-pass filters to imageMat, and returns a three-fields
%   structure.
%   FILTEREDIMG = CASCADEFILTERSURROGATES(IMAGEMAT, 'LOWPASSITERATION', N)
%   applies N cascade gaussian low-pass filters to imageMat.
%   FILTEREDIMG = CASCADEFILTERSURROGATES(IMAGEMAT, 'FILTERTYPE', FILTER)
%   applies the selected FILTER to imageMat three times. FILTER can be one
%   of either 'gaussian' or 'median'.

p = inputParser;
allowedFilterTypes = {'gaussian', 'median'};
addRequired(p, 'ImageMat', ...
    @(x) assert(isnumeric(x), 'It must be a H x W x K matrix.'));
addParameter(p, 'LowPassIteration', 3, ...
    @(x) assert(isscalar(x), 'It must be an integer.'));
addParameter(p, 'FilterType', 'gaussian', ...
    @(x) assert(any(validatestring(x, allowedFilterTypes), ...
        'It must be an allowed filter type.')));

parse(p, image, varargin{:});

% Iterate low pass filtering until LowPassIteration limit is reached.
for i = 1:p.Results.LowPassIteration
    filtImg = zeros(size(image,1), size(image,2), size(image,3));
    % Iterate on each channel of the image, then extract histogram.
    for k = 1:size(image, 3)
        switch p.Results.FilterType
            case 'gaussian'
                filtImg(:,:,k) = imgaussfilt(image(:,:,k));
            case 'median'
                filtImg(:,:,k) = medfilt2(image(:,:,k));
        end
    end
    image = cat(3,filtImg(:,:,1), filtImg(:,:,2), filtImg(:,:,3));
    fldnm = strcat('filtered_', int2str(i));
    filteredImg.(fldnm) = image;
end