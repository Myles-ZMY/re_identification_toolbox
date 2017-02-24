function [idx,C] = featureClustering(featVec, varargin)
%FEATURECLUSTERING Perform cluster analysis on a vector of features.
%   
%Summary of this function goes here
%   Detailed explanation goes here

% Input parser
p = inputParser;

defClustAlg = 'kmeans';
defParsMeth = 'silhouette';
defMinK = 1;
defMaxK = 10;
defCons = false;

% Allowed parameters.
alwClustAlg = {'kmeans','linkage','gmdistribution'};
alwParsMeth = {'CalinskiHarabasz','DaviesBouldin','silhouette','gap'};

addRequired(p, 'FeatureVector')
addParameter(p, 'ClusteringAlgorithm', ...
    defClustAlg, ...
    @(x) any(validatestring(x,alwClustAlg)));
addParameter(p, 'ParsingMethod', ...
    defParsMeth, ...
    @(x) any(validatestring(x,alwParsMeth)));
addOptional(p, 'MinK', defMinK, @isnumeric);
addOptional(p, 'MaxK', defMaxK, @isnumeric);
addOptional(p, 'Consensus', defCons, @islogical);

parse(p,featVec,varargin{:});

% Perform Kolmogorov-Smirnov test
% TODO: CHECK HYPOTHESIS FOR ALL CLUSTERING METHODS
if strcmp(p.Results.ClusteringAlgorithm,'kmeans')
    if ~kstest(featVec)
        p.Results.ClusteringAlgorithm = 'linkage';
    end
end

if ~p.Results.Consensus
    e = evalclusters(featVec, ...
        p.Results.ClusteringAlgorithm, ...
        p.Results.ParsingMethod, ...
        'KList', p.Results.MinK:p.Results.MaxK);
    k = e.OptimalK;
elseif p.Results.Consensus
    % Simple consensus algorithm
    k_vec = zeros(1,4);
    for i = 1:4
        e = evalclusters(featVec, ...
            p.Results.ClusteringAlgorithm, ...
            alwParsMeth{i}, ...
            'KList', p.Results.MinK:p.Results.MaxK);
        k_vec(i) = e.OptimalK;
    end
    k = mode(k_vec);
end

switch p.Results.ClusteringAlgorithm
    case 'kmeans'
        [idx, C] = kmeans(featVec, k);
    case 'linkage'
        
    case 'gmdistribution'
        
end

end