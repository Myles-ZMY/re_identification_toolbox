function [i, ni, fi, ti]  = imAugmentedRead(img, varargin)
% TODO: ADD ROTATION
%IMAUGMENTEDREAD Read an image, and augment it using label-preserving 
%transforms.
%   [I, NI, FI, TI, RI, LBL] = IMAUGMENTEDREAD(IMG, VARARGIN) reads the image
%   IMG and returns a matrix I, which represents the original image, a
%   noisy version of the original image (RI), a horizontally-flipped
%   version (FI), a transformed version (TI) and a rotated version (RI).
%   Several optional parameters can be specified:
%   - NoiseType: a string which represents the type of the noise which is
%   added to the image. Allowed values are GAUSSIAN, LOCALVAR, POISSON,
%   SALT & PEPPER, SPECKLE;
%   - TransformStep: a scalar value, which must be included between 0 and
%   1, and represents the size of the transformation;
%   - RotationMap: a 3x3 real values matrix which represents the rotation
%   matrix to compute the rotated image.

p = inputParser;
expectedNoiseType = {'gaussian', 'localvar', 'poisson', ...
    'salt & pepper', 'speckle'};
addRequired(p, 'ImageName', @ischar);
addParameter(p, 'NoiseType', 'salt & pepper', @(x) ...
    any(validatestring(x,expectedNoiseType), 'Unrecognized noise'));
addParameter(p, 'TransformStep', 0.05, @(x) assert(isscalar(x) ...
    && (x > 0) && (x < 1), ...
    'Transform step must be a scalar value between 0 and 1.'));
addParameter(p, 'RotationMat', ...
    [1 .05 0; .05 1 0; 0 .05 1], ...
    @(x) assert(ismatrix(x) ...
    && (size(x,1) == size(x,2)) && (size(x,1) == 3), ...
    'Rotation matrix must be a 3 x 3 matrix'));
addParameter(p, 'IsHsv', false, @islogical);

parse(p, img, varargin{:});

% Read image.
i = imread(img);
% Transform image if needed
if p.Results.IsHsv
    i = rgb2hsv(i);
end
% Noisy image.
ni = imnoise(i, p.Results.NoiseType);
% Horizontally flipped image.
fi = fliplr(i);
% Transform image, using a random number from +-TransformStep.
h = size(i,1)*p.Results.TransformStep;
w = size(i,2)*p.Results.TransformStep;
h_disp = (h-2*h)*randn(1,1) + h;
w_disp = (w-2*w)*randn(1,1) + w;
ti = imtranslate(i, [h_disp, w_disp]);
% Rotate image.
tform = affine2d(p.Results.RotationMat);
%ri = imwarp(i, tform);

end