% This is the main access point to the re-id toolbox.
clearvars; clc; close all hidden;

% Parameters are stored in a struct (pars).
% TODO: RE-ARRANGE PARAMETERS
pars.dataset        = 'ViPER'; % Dataset used for the experiment.
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
pars.nbins          = 16;
pars.nchannels      = 3;
pars.deep_learning  = 0; % Indicates wether libs for DL should be downloaded
pars.save           = true;

% Initialize parallel pool
if pars.parallel
    parallel_pool = gcp;
end

%Setup paths
setup

% TODO: NORMALIZE IMAGES WHICH MUST BE READ

% Read images and store them in two tensors, i.e. p_set and g_set.
imgTensorMat = [resDir '\augmented_' pars.dataset '_' pars.exp_no '.mat'];
if (pars.save && ~exist(imgTensorMat,'file'))
    [probeSet, gallerySet] = imageReader(currentDatasetDir, '*.bmp', pars.height, pars.width, pars.channels);
    save(imgTensorMat, 'probeSet', 'gallerySet');
else
    load(imgTensorMat)
end

[s_p_set, s_g_set] = imageSegmentation(probeSet.originalImages, gallerySet.originalImages, pars);

[exit1,exit2] = extractColorFeatures(s_p_set, s_g_set, pars.nbins, pars.nchannels);
[stat1,stat2] = extractStatisticsFromFeatures(exit1,exit2);

% pseudo code: feat_vec = squeeze(stat1(:,i,:,i))';
% featureClustering(feat_vec)