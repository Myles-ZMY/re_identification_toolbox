% This is the main access point to the re-id toolbox.
clearvars; clc; close all hidden;

% Parameters are stored in a struct (pars).
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

% Initialize parallel pool
if pars.parallel
    gcp;
end

% Setup paths
setup_paths

% Read images and store them in two tensors, i.e. p_set and g_set.
tic
[p_set, g_set, pars.image_no] = imageReader(dset_dir, '*.bmp', pars);
toc
tic
[s_p_set, s_g_set] = imageSegmentation(p_set, g_set, pars);
toc