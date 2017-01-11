function [s_p_set, s_g_set] = imageSegmentation(p_set, ...
                                                g_set, ...
                                                pars)
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
elseif size(p_set,4)~=size(g_set,4)
    error('Gallery set and probe set contain a different number of images.');
elseif ~isstruct(pars)
    error('pars struct.')
    %TODO CHECK IF PARS HAS V_PATCHES, H_PATCHES
end

% TODO: DOCS + REFACTORING
% Step vectors
h_vec = 0:(floor(pars.height/pars.h_patches)):pars.height;
h_vec_a = h_vec + 1;
v_vec = 0:(floor(pars.width/pars.v_patches)):pars.width;
v_vec_a = v_vec + 1;

s_p_set = [];
s_g_set = [];

% consider h stripe
for i = 1:(length(h_vec)-1)
    p_stripe = p_set(h_vec_a(i):h_vec(i+1),:,:,:);
    g_stripe = g_set(h_vec_a(i):h_vec(i+1),:,:,:);
    for j = 1:length(v_vec)-1
        p_col = p_stripe(:,v_vec_a(j):v_vec(j+1),:,:);
        g_col = g_stripe(:,v_vec_a(j):v_vec(j+1),:,:);
        s_p_set = cat(5,s_p_set,p_col);
        s_g_set = cat(5,s_g_set,g_col);
    end
end

end