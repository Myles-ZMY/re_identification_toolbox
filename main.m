% This is the main access point to the re-id toolbox.
clearvars; clc; close all hidden;

% Params are stored in a struct (pars) which specifies supported datasets.
pars.dataset = 'ViPER';
pars.normalize = 1;
pars.height = 128;
pars.width = 48;
pars.channels = 3;
pars.parallel = 1;
pars.gpu = 0;
pars.multi_shot = 0;

% Initialize parallel pool
if pars.parallel
    gcp;
end

% Setup paths
setup_paths

% Read images and store them in two tensors, i.e. p_set and g_set.
[p_set, g_set, dset_size] = imageReader(dset_dir, '*.bmp', pars);