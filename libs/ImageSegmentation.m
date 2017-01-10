function [s_p_set, s_g_set] = imageSegmentation(p_set, g_set, mode)
%IMAGESEGMENTATION Segments images in both a probe and a gallery set
%according to the specified mode.
%   [S_P_SET, S_G_SET] = IMAGESEGMENTATION(P_SET, G_SET, MODE) accepts as
%   inputs two tensors, one for the probe set, and the other for the
%   gallery set, extracted from a person re-identification dataset, and
%   performs a trivial image segmentation according to the specified mode.
%   MODE can take the following values:
%   - SIX_STRIPES: splits each image in six horizontal stripes.
%   - DENSE: splits each image in 8 x 8 patches.
if nargin~=3
    error('The number of input arguments is not correct.');
elseif size(p_set,4)~size(g_set,4)
    error('Gallery set and probe set contain a different number of images.');
elseif ~isstring(mode)
    error('Mode must be a string.')
end

img_no = size(p_set,4);

if(strcmp(mode,'six_stripes'))
    s_p_set = zeros(size(p_set,1)/6,size(p_set,2)/6,6,size(p_set,3),size(p_set,4));
    s_g_set = s_p_set;
    parfor i = 1:img_no
        p_img = p_set(:,:,:,i);
        g_img = g_set(:,:,:,i);
        if ~(size(p_img,1)==128 && size(p_img,2)==48)
            p_img = imresize(p_img, [128, 48]);
        end
        if ~(size(g_img,1)==128 && size(g_img,2)==48)
            g_img = imresize(g_img, [128, 48]);
        end
        s_p_set(i) = reshape(p_img,[size(p_img,1)/6, size(p_img,2)/6, 6, ...
            size(p_img,3), size(p_img,4)]);
        s_g_set(i) = reshape(g_img,[size(g_img,1)/6, size(g_img,2)/6, 6, ...
            size(g_img,3), size(g_img,4)]);
    end
elseif(strcmp(mode,'dense'))
%    s_p_set = zeros(size(p_set,1)/8,size(p_set,2)/8, 
else
    error('Unrecognized segmentation mode.');    
end

end