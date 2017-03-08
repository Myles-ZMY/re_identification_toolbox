function statFeatures = helperExtractStatisticsFromFeatures(colorFeatures)
%HELPEREXTRACTSTATISTICSFROMFEATURES Wrapper on the
%extractStatisticsFromFeatures function.
%   statFeatures = HELPEREXTRACTSTATISTICSFROMFEATURES(colorFeatures)
%   iterates through each field of the colorFeatures structure, calling
%   extractStatisticsFromFeatures(colorFeaturs.field) at each iteration.

p = inputParser;
addRequired(p, 'ColorFeatures', ...
    @(x) assert(isstruct(x) || isnumeric(x), ...
    'It must be either a structure or an array of structures.'));

parse(p, colorFeatures);

if isstruct(colorFeatures)
    fields = fieldnames(colorFeatures, '-full');
    for i = 1:numel(fields)
        statFeatures.(fields{i}) = extractStatisticsFromFeatures(colorFeatures.(fields{i}));
    end
elseif isnumeric(colorFeatures)
    %statFeatures(n)
    for i = 1:numel(colorFeatures)
        fields = fieldnames(colorFeatures(i), '-full');
        for j = 1:numel(fields)
            statFeatures(i).(fields{j}) = getStatFeatures(colorFeatures(i).(fields{j}));            
        end
    end
end

    %function out = getStatFeatures(colorFeaturesStruct)
    %    fields = fieldnames(colorFeatures, '-full');
    %    for i = 1:numel(fields)
    %        out.(fields{i}) = extractStatisticsFromFeatures(colorFeaturesStruct.(fields{i}));
    %    end
    %end

end