function [idx,C] = featureClustering(feature_vector, varargin)
%FEATURECLUSTERING Perform cluster analysis on a vector of features.
%   
%Summary of this function goes here
%   Detailed explanation goes here

% Input parser
p = inputParser;

% Default parameters
defaultClusteringAlgorithm = 'kmeans';
defaultParsingMethod = 'silhouette';
defaultMinK = 1;
defaultMaxK = 10;
defaultConsensus = false;

% Expected parameters
expectedClusteringAlgorithms = {'kmeans','linkage','gmdistribution'};
expectedParsingMethods = {'CalinskiHarabasz','DaviesBouldin','silhouette','gap'};

addParameter(p, 'clusteringAlgorithm', ...
    defaultClusteringAlgorithm, ...
    @(x) any(validatestring(x,expectedClusteringAlgorithms)));
addParameter(p, 'parsingMethod', ...
    defaultParsingMethod, ...
    @(x) any(validatestring(x,expectedParsingMethods)));
addOptional(p, 'minK', defaultMinK, @isnumeric);
addOptional(p, 'maxK', defaultMaxK, @isnumeric);
addOptional(p, 'consensus', defaultConsensus, @islogical);

parse(p,varargin{:});

% Perform Kolmogorov-Smirnov test
% TODO: CHECK HYPOTHESIS FOR ALL CLUSTERING METHODS
if strcmp(p.Results.clusteringAlgorithm,'kmeans')
    if ~kstest(feat_vec)
        p.Results.clusteringAlgorithm = 'linkage';
    end
end

if ~p.Results.consensus
    e = evalclusters(feature_vector, ...
        p.Results.clusteringAlgorithm, ...
        p.Results.parsingMethod, ...
        'KList', p.Results.minK:p.Results.maxK);
    k = e.OptimalK;
elseif p.Results.consensus
    % Simple consensus algorithm
    k_vec = zeros(1,4);
    for i = 1:4
        e = evalclusters(feature_vector, ...
            p.Results.clusteringAlgorithm, ...
            expectedParsingMethods{i}, ...
            'KList', p.Results.minK:p.Results.maxK);
        k_vec(i) = e.OptimalK;
    end
    k = mode(k_vec);
end

switch p.Results.clusteringAlgorithm
    case 'kmeans'
        [idx, C] = kmeans(feature_vector, k);
    case 'linkage'
        
    case 'gmdistribution'
        
end

end