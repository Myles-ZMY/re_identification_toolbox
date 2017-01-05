% This serves as main script for re-identification toolbox. Use it instead
% of GUI if you want a better control on the whole process.

% Params are stored in a struct (pars) which specifies supported datasets.
pars.dataset = 'ViPER';
pars.normalize = 1;

% Initialize parallel pool
parpool;

