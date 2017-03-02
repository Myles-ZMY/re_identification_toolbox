function statFeatures = helperExtractStatisticsFromFeatures(colorFeatures)
%HELPEREXTRACTSTATISTICSFROMFEATURES Wrapper on the
%extractStatisticsFromFeatures function.
%   statFeatures = HELPEREXTRACTSTATISTICSFROMFEATURES(colorFeatures)
%   iterates through each field of the colorFeatures structure, calling
%   extractStatisticsFromFeatures(colorFeaturs.field) at each iteration.

p = inputParser;
addRequired(p, 'ColorFeatures', ...
    @(x) assert(isstruct(x), 'It must be a structure.'));

parse(p, colorFeatures);

fields = fieldnames(colorFeatures, '-full');

for i = numel(fields)
    statFeatures.(fields{i}) = extractStatisticsFromFeatures(colorFeatures.(fields{i}));
end

end