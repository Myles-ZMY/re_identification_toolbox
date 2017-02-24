function [hist1, hist2] = helperExtractColorFeatures( segProbeSet, segGallerySet )
%HELPEREXTRACTCOLORFEATURES Summary of this function goes here
%   Detailed explanation goes here

% TODO PARAMETERS + INPUT + HElP
[hist1.original,hist2.original] = extractColorFeatures(segProbeSet.originalImages, segGallerySet.originalImages, 16, 3);
[hist1.noisy,hist2.noisy] = extractColorFeatures(segProbeSet.noisyImages, segGallerySet.noisyImages, 16, 3);
[hist1.flip,hist2.flip] = extractColorFeatures(segProbeSet.flipImages, segGallerySet.flipImages, 16, 3);
[hist1.transf,hist2.transf] = extractColorFeatures(segProbeSet.transfImages, segGallerySet.transfImages, 16, 3);

end

