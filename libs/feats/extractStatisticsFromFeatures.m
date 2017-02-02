function varargout = extractStatisticsFromFeatures(varargin)
%EXTRACTSTATISTICSFROMFEATURES Statistical characterization of feature
%distribution.
%   TODO: REFACTORING DOCS
%   FEATURE_STATS = EXTRACTSTATISTICSFROMFEATURES(FEATURE_SET) extracts
%   meaningful statistical parameters (i.e. mean, median, variance and 
%   interquartile range) froma given FEATURE_SET, which is assumed to be a
%   column vector. No assumptions are made on the shape of the
%   distribution, which can be both non-parametric and parametric.

varargout = cell(length(varargin));

for i = 1:length(varargin)
    varargout{i} = cat(1, ...
        mean(varargin{i}), ...
        median(varargin{i}), ...
        std(varargin{i}), ...
        iqr(varargin{i}));
end

end