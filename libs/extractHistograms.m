function hist_ten = extractHistograms(dset,nbins,nchannels)
%EXTRACTHISTOGRAM Extract histograms of images contained in a dataset.
%   HIST_MAT = EXTRACTHISTOGRAM(DSET,NBINS,NCHANNELS) returns a BxCxDxS
%   tensor, where:
%   - N is the number of bins (NBINS);
%   - C is the number of channels (NCHANNELS);
%   - D is the number of images in the dataset;
%   - S is the number of segments in which each image of the dataset is
%   splitted.
if nargin~=3
    error('Check input number.')
end

% Preallocate hist_ten tensor.
hist_ten = zeros(nbins, nchannels, size(dset,4), size(dset,5));
% Extract the histogram of the specified channels with the specific number
% of bins.
% TODO: PARFOR/GPU
for i = 1:size(dset,4)
    for j = 1:size(dset,5)
        for k = 1:nchannels
            hist_ten(:,k,i,j) = histcounts(dset(:,:,k,i,j),nbins,'Normalization','probability');
        end
    end
end

end