function [segProbeSet, segGallerySet] = helperImageSegmentation(probeSet, gallerySet)

% TODO: HELP + INPUT PARSING
% TODO: PARAMETERS
[segProbeSet.originalImages, segGallerySet.originalImages] = imageSegmentation(probeSet.originalImages, gallerySet.originalImages);
[segProbeSet.noisyImages, segGallerySet.noisyImages] = imageSegmentation(probeSet.noisyImages, gallerySet.noisyImages);
[segProbeSet.flipImages, segGallerySet.flipImages] = imageSegmentation(probeSet.flipImages, gallerySet.flipImages);
[segProbeSet.transfImages, segGallerySet.transfImages] = imageSegmentation(probeSet.transfImages, gallerySet.transfImages);


end