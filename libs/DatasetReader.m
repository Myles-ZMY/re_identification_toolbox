function imds = DatasetReader(ddir, ime)
%IMAGEREADER Reads a dataset composed by several images, and stores it into
%a datastore.
%   IMDS = DATASETREADER(DDIR, IME) is a wrapper built on top of the
%   imageDatastore built-in function. It reads all the images with
%   extension IME within the directory DDIR, an returns an image datastore
%   IMDS.

% Read image files and organize them in a cell array.
imf = dir([ddir, ime]);
imfc = {imf.name};

% Organize images in an image datastore.
imds = imageDatastore(imfc);

end

