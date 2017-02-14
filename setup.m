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

% TODO: parametrize
if(pars.deep_learning)
    unzip('https://github.com/vlfeat/matconvnet/archive/master.zip', libsDir);
    addpath(fullfile(libsDir, 'matconvnet-master', 'matlab'));
    compileGpu = false;
    if((gpuDeviceCount > 0) && pars.gpu)
        g = gpuDevice;
        if g.computeCapability > 3
            compileGpu = true;
        else
            warning('GPU is not enough');
        end
    end
            
    vl_compilenn('enableGpu',compileGpu);
    vl_setupnn;
end