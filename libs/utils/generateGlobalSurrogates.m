function [noisyDataset, translateDataset, surrogateDataset] = generateGlobalSurrogates(dataset, varargin)
%GENERATEGLOBALSURROGATES Reads an image, and generates surrogates using
%label-preserving transforms.
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
allowedNoises = {'gaussian', ...
    'localvar', ...
    'poisson', ...
    'salt & pepper', ...
    'speckle'};

addRequired(p, 'Dataset', ...
    @(x) assert(isstruct(x), 'It must be a struct'));
addParameter(p, 'NoiseType', 'salt & pepper', ...
    @(x) assert(any(validatestring(x,allowedNoises)), ...
        'Unrecognized noise type'));
addParameter(p, 'TransformStep', 0.05, ...
    @(x) assert(isscalar(x) && (x > 0) && (x < 1), ...
    'Transform step must be a scalar value between 0 and 1.'));

parse(p, dataset, varargin{:});

fields = fieldnames(dataset, '-full');
tic
for i = 1:numel(fields)
    for j = 1:size(dataset.(fields{i}), 4)
        noisyDataset.(fields{i})(:,:,:,j) = imnoise(dataset.(fields{i})(:,:,:,j), p.Results.NoiseType);
        flippedLrDataset.(fields{i})(:,:,:,j) = fliplr(dataset.(fields{i})(:,:,:,j));
        flippedUdDataset.(fields{i})(:,:,:,j) = fliplr(dataset.(fields{i})(:,:,:,j));
        h = size(dataset.(fields{i})(:,:,:,j),1)*p.Results.TransformStep;
        w = size(dataset.(fields{i})(:,:,:,j),2)*p.Results.TransformStep;
        hDisplacement = (h-2*h)*randn(1,1) + h;
        wDisplacement = (w-2*w)*randn(1,1) + w;
        translateDataset.(fields{i})(:,:,:,j) = imtranslate((dataset.(fields{i})(:,:,:,j)), [hDisplacement, wDisplacement]);
        surrogateDataset.(fields{i})(:,:,:,j) = cascadeFilterSurrogates(dataset.(fields{i})(:,:,:,j));
    end
end
toc
%transl = imtranslate(dataset, [hDisplacement, wDisplacement]);
% TODO: move in imremovepadding function
% Remove zero padding.
%hR = transl(:,:,1);
%hG = transl(:,:,2);
%hB = transl(:,:,3);
%hR( ~any(hR,2), : ) = [];  %rows
%hR( :, ~any(hR,1) ) = [];  %columns
%hG( ~any(hG,2), : ) = [];  %row
%hG( :, ~any(hG,1) ) = [];  %columns
%hB( ~any(hB,2), : ) = [];  %rows
%hB( :, ~any(hB,1) ) = [];  %columns
%t = cat(3, hR, hG, hB);

%surrogate.translatedImage = t;

%surrogate.filteredImgs = cascadeFilterSurrogates(dataset);

end