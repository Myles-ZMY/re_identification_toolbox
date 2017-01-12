function varargout = extractColorFeatures( s_p_set, s_g_set, nbins, nchannels )
%EXTRACTCOLORFEATURES Extracts color features in a given image. This is a
%wrapper around several different color feature extraction.
%is a Summary of this function goes here
%   Detailed explanation goes here

% TODO: CHECK INPUT

% Extract RGB histograms.
varargout{1} = extractHistograms(s_p_set, nbins, nchannels);
varargout{2} = extractHistograms(s_g_set, nbins, nchannels);

end