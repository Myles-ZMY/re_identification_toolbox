function [ output_args ] = extractGaborFeatures( wavelenght, orientation, s_p_set, s_g_set, dset_size )
%EXTRACTGABORFEATURES Summary of this function goes here
%   Detailed explanation goes here
% TODO CHECK INPUT

g = gabor(wavelength,orientation);
parfor i = 1:dset_size
    
end


end

