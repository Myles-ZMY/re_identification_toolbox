function [sProbeSet, sGallerySet] = imageSegmentation(probeSet, gallerySet, varargin)

%IMAGESEGMENTATION Segments images in both a probe and a gallery set
%according to the specified mode.
%   [S_P_SET, S_G_SET] = IMAGESEGMENTATION(P_SET, G_SET, MODE) accepts as
%   inputs two tensors, one for the probe set, and the other for the
%   gallery set, extracted from a person re-identification dataset, and
%   performs a trivial image segmentation according to the specified mode.
%   MODE can take the following values:
%   - SIX_STRIPES: splits each image in six horizontal stripes.
%   - DENSE: splits each image in 8 x 8 patches.

p = inputParser;
expectedFields = {'originalImages','noisyImages','flipImages', ...
    'transfImages','rotatedImages'};
setValidationFcn = @(x) assert(isstruct(x) && ...
    isequal(fieldnames(x,'-full'),expectedFields), ...
    'Structure fields are not vaid. Check documentation.');
addRequired(p, 'probeSet', setValidationFcn);
addRequired(p, 'gallerySet', setValidationFcn);

parse(p, probeSet, gallerySet, varargin{:});

% TODO: this should be modified to extract several color space, and store
% them in mat files

% TODO: DOCS + REFACTORING
% Step vectors
h_vec = 0:(floor(pars.height/pars.h_patches)):pars.height;
h_vec_a = h_vec + 1;
v_vec = 0:(floor(pars.width/pars.v_patches)):pars.width;
v_vec_a = v_vec + 1;

sProbeSet = [];
sGallerySet = [];

% consider h stripe
for i = 1:(length(h_vec)-1)
    p_stripe = probeSet(h_vec_a(i):h_vec(i+1),:,:,:);
    g_stripe = g_set(h_vec_a(i):h_vec(i+1),:,:,:);
    for j = 1:length(v_vec)-1
        p_col = p_stripe(:,v_vec_a(j):v_vec(j+1),:,:);
        g_col = g_stripe(:,v_vec_a(j):v_vec(j+1),:,:);
        sProbeSet = cat(5,sProbeSet,p_col);
        sGallerySet = cat(5,sGallerySet,g_col);
    end
end

end