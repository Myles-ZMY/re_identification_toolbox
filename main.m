% This is the main access point to the re-id toolbox.
clearvars; clc; close all hidden;

% Parameters are stored in a struct (pars).
% TODO: RE-ARRANGE PARAMETERS
pars.dataset        = 'VIPeR'; % Dataset used for the experiment.
pars.exp_no         = '001'; % Experiment number.
pars.normalize      = 1; % Normalize images to the specified height and width.
pars.height         = 128; % Normalized height of the images.
pars.width          = 48; % Normalized width of the images.
pars.channels       = 3; % Channels of the images.
pars.parallel       = 1; % Use parpool
pars.gpu            = 0; % Use GPU
pars.multi_shot     = 0; % indicates if dataset is multishot
pars.h_patches      = 6;
pars.v_patches      = 2;
pars.nBins          = 16;
pars.nChannels      = 3;
pars.deep_learning  = 0; % Indicates wether libs for DL should be downloaded
pars.save           = true;

% Initialize parallel pool
if pars.parallel
    parallel_pool = gcp;
end

% Setup paths; TODO: organize in a function - move parpool in setup
setup

% TODO: NORMALIZE IMAGES WHICH MUST BE READ

%% Read dataset and split it in probe set and gallery set.
imgTensorMat = [resDir '\' pars.dataset '_' pars.exp_no '.mat'];
if (pars.save && ~exist(imgTensorMat,'file'))
    dataset = imageReader(currentDatasetDir, '*.bmp');
    save(imgTensorMat, 'dataset');
else
    load(imgTensorMat)
end

%% Generate global surrogates.
%
surrogateMat = [resDir '\' pars.dataset '_' pars.exp_no '_surrogates.mat'];
if (pars.save && ~exist(surrogateMat,'file'))
    [noisyDset, flipLrDset, flipUdDset, transDset, filtDset] = ...
        generateGlobalSurrogates(dataset);
    save(surrogateMat, ...
        'noisyDset', 'flipLrDset', 'flipUdDset', 'transDset', 'filtDset');
else
    load(surrogateMat)
end

%% Extract global color features
colorFeatures(1) = extractColorFeatures(dataset, ...
    'NumBins', pars.nBins, ...
    'NumChannels', pars.nChannels);
colorFeatures(2) = extractColorFeatures(noisyDset, ...
    'NumBins', pars.nBins, ...
    'NumChannels', pars.nChannels);
colorFeatures(3) = extractColorFeatures(flipLrDset, ...
    'NumBins', pars.nBins, ...
    'NumChannels', pars.nChannels);
colorFeatures(4) = extractColorFeatures(flipUdDset, ...
    'NumBins', pars.nBins, ...
    'NumChannels', pars.nChannels);
colorFeatures(5) = extractColorFeatures(transDset, ...
    'NumBins', pars.nBins, ...
    'NumChannels', pars.nChannels);
% TODO: DEBUG FILTDSET
%colorFeatures(6) = extractColorFeatures(filtDset, ...
%    'NumBins', pars.nBins, ...
%    'NumChannels', pars.nChannels);

statFeatures = helperExtractStatisticsFromFeatures(colorFeatures);

% TODO: SAVE/LOAD SEGM DATASET

% TODO: SAVE FILES

% TODO: EXTRACT EACH CHANNEL + LABELS


% pseudo code: feat_vec = squeeze(stat1(:,i,:,i))';
% featureClustering(feat_vec)