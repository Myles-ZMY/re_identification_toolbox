function [stat1,stat2] = helperExtractStatisticsFromFeatures( hist1,hist2 )
% Summary of this function goes here
%   Detailed explanation goes here

[stat1.original,stat2.original] = extractStatisticsFromFeatures(hist1.original,hist2.original);
[stat1.noisy,stat2.noisy] = extractStatisticsFromFeatures(hist1.noisy,hist2.noisy);
[stat1.flip,stat2.flip] = extractStatisticsFromFeatures(hist1.flip,hist2.flip);
[stat1.transf,stat2.transf] = extractStatisticsFromFeatures(hist1.transf,hist2.transf);
end

