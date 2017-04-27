% Main dataset folder. It stores all the normalized datasets.
mainDatasetDir = fullfile(pwd, 'datasets');
if ~exist(mainDatasetDir, 'dir')
    mkdir(mainDatasetDir)
end

% Current dataset folder. If it does not exist, call normalizeDataset.
currentDatasetDir = fullfile(mainDatasetDir, pars.dataset);
%if ~exist(currentDatasetDir, 'dir')
%    normalizeDataset;
%end

% Library folder. 
libsDir = fullfile(pwd, 'libs');
% Check if library folder is already on path. If not, add it.
pathCell = regexp(path, pathsep, 'split');
if ((ispc && ~any(strcmpi(libsDir, pathCell))) || ~any(strcmp(libsDir, pathCell)))
    addpath(genpath(libsDir));
end

% Results folder.
resDir = fullfile(pwd, 'res');
if ~exist(resDir,'dir')
    mkdir(resDir)
end

imds = imageDatastore(currentDatasetDir, 'FileExtensions', '.bmp', 'IncludeSubfolder', 1);
labels = categorical(repmat((1:632)',2,1));
imds.Labels = labels;