function [sProbeSet, sGallerySet] = imageSegmentation(probeSet, gallerySet, varargin)

%IMAGESEGMENTATION Segments images in both a probe and a gallery set
%according to the specified mode.

p = inputParser;
expectedFields = {'originalImages','noisyImages','flipImages', ...
    'transfImages','rotatedImages'}';
setValidationFcn = @(x) assert(isstruct(x) && ...
    isequal(fieldnames(x,'-full'),expectedFields), ...
    'Structure fields are not vaid. Check documentation.');
%integerValidationFcn = @(x,msg) assert(isinteger(x), msg);
addRequired(p, 'probeSet', setValidationFcn);
addRequired(p, 'gallerySet', setValidationFcn);
addParameter(p, 'Height', 128, @(x) assert(isinteger(x), ...
    'Height parameter must be scalar. Check documentation.'));
addParameter(p, 'Width', 48, @(x) assert(isinteger(x), ...
    'Width parameter must be scalar. Check documentation.'));
addParameter(p, 'HorizontalPatches', 1, @(x) assert(isinteger(x), ...
    'The number of horizontal patches must be an integer value.'));
addParameter(p, 'VerticalPatches', 1, @(x) assert(isinteger(x), ...
    'The number of vertical patches must be an integer value.'));

parse(p, probeSet, gallerySet, varargin{:});

% TODO: this should be modified to extract several color space, and store
% them in mat files

% TODO: DOCS + REFACTORING
% Step vectors
h_vec = 1:(floor(p.Results.Height/p.Results.HorizontalPatches)): ...
    p.Results.Height;
h_vec_a = h_vec + 1;
v_vec = 1:(floor(p.Results.Width/p.Results.VerticalPatches)): ...
    p.Results.VerticalPatches;
v_vec_a = v_vec + 1;

[h_vec,v_vec] = splitMatrix(p.Results.Height, ...
    p.Results.Width, ...
    p.Results.HorizontalPatches, ...
    p.Results.VerticalPatches);

sProbeSet = [];
sGallerySet = [];

% consider h stripe
for i = 1:(length(h_vec)-1)
    p_stripe = probeSet.originalImages(h_vec(i):h_vec(i+1),:,:,:);
    g_stripe = gallerySet.originalImages(h_vec(i):h_vec(i+1),:,:,:);
    for j = 1:length(v_vec)-1
        p_col = p_stripe(:,v_vec(j):v_vec(j+1),:,:);
        g_col = g_stripe(:,v_vec(j):v_vec(j+1),:,:);
        sProbeSet = cat(5,sProbeSet,p_col);
        sGallerySet = cat(5,sGallerySet,g_col);
    end
end

end