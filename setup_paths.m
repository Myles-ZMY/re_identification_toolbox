% Dataset main folder; it stores all the datasets which should be
% evaluated.
dset_main_dir = fullfile(pwd, 'datasets');
% Dataset folder used in the experiment, according to the parameters
% structure.
dset_dir = fullfile(dset_main_dir, pars.dataset);
% Library folder. It is added to the path to recall libraries without
% specifying it.
lib_dir = fullfile(pwd, 'libs');
addpath(lib_dir);