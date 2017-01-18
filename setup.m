% TODO: INITIAL SETUP (add folders if they do not exist)
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
% Res folder.

if(pars.deep_learning)
    unzip('https://github.com/vlfeat/matconvnet/archive/master.zip', lib_dir);
    % TODO: PARAMETRIZE
    vl_compilenn('enableGpu',1,'verbose',verbose);
    vl_setupnn;
end