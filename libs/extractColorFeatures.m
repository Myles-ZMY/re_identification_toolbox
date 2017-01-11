function [ output_args ] = extractColorFeatures( s_p_set, s_g_set )
%EXTRACTCOLORFEATURES Extracts color features in a given image. This is a
%wrapper around several different color feature extraction.
%is a Summary of this function goes here
%   Detailed explanation goes here

img_no = size(s_p_set,4);
ch_no = size(s_p_set,3);
% TODO: CHECK INPUT
parfor i = 1:img_no
    for i = 1:ch_no
        
    end
end

end

