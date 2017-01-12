function feature_stats = extractStatisticsFromFeatures(feature_set)
%EXTRACTSTATISTICSFROMFEATURES Statistical characterization of feature
%distribution.
%   FEATURE_STATS = EXTRACTSTATISTICSFROMFEATURES(FEATURE_SET) extracts
%   meaningful statistical parameters (i.e. mean, median, variance and 
%   interquartile range) froma given FEATURE_SET, which is assumed to be a
%   column vector. No assumptions are made on the shape of the
%   distribution, which can be both non-parametric and parametric.
% TODO: CHECK INPUT
% TODO: HYPOTHESIS ON THE DISTRIBUTION (i.e. normalized, a classical
% histogram should not work)

% NORMALIZATION
% if (sum(feature_set)!=1) normalize

feature_stats = [mean(feature_set), ...
    median(feature_set), ...
    std(feature_set), ...
    iqr(feature_set)];

end

