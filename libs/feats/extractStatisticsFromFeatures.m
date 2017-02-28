function statStruct = extractStatisticsFromFeatures(featureStruct)
%EXTRACTSTATISTICSFROMFEATURES Statistical characterization of feature
%distribution.
%   TODO: REFACTORING DOCS
%   FEATURE_STATS = EXTRACTSTATISTICSFROMFEATURES(FEATURE_SET) extracts
%   meaningful statistical parameters (i.e. mean, median, variance and 
%   interquartile range) froma given FEATURE_SET, which is assumed to be a
%   column vector. No assumptions are made on the shape of the
%   distribution, which can be both non-parametric and parametric.

p = inputParser;
addRequired(p, 'FeatureStruct', ...
    @(x) assert(isstruct(x), 'It must be a structure.'));

parse(p, featureStruct);

fields = fieldnames(p.Results.FeatureStruct);

% TODO: PARAM HISTMEANS!
for i = 1:numel(fields)
    statStruct.(fields{i}) = cat(1, histMean(featureStruct.(fields{i}),256), ...
        median(featureStruct.(fields{i})), ...
        std(featureStruct.(fields{i})), ...
        iqr(featureStruct.(fields{i})));
end

end