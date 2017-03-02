function statStruct = extractStatisticsFromFeatures(featureStruct)
%EXTRACTSTATISTICSFROMFEATURES Statistical characterization of feature
%distribution.
%   STATSTRUCT = EXTRACTSTATISTICSFROMFEATURES(FEATURESTRUCT) extract
%   statistical parameters from each field in FEATURESTRUCT, after
%   verifying its coherence through the HELPERCHKDSETSTRUCT function. No
%   assumption are made about the shape of the distribution, which can be
%   either non-parametric or parametric.

p = inputParser;
addRequired(p, 'FeatureStruct', ...
    @(x) assert(isstruct(x), 'It must be a structure.'));

parse(p, featureStruct);

fields = fieldnames(p.Results.FeatureStruct);

for i = 1:numel(fields)
    statStruct.(fields{i}) = cat(1, histMean(featureStruct.(fields{i})), ...
        median(featureStruct.(fields{i})), ...
        std(featureStruct.(fields{i})), ...
        iqr(featureStruct.(fields{i})));
end

end