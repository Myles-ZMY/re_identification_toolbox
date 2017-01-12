function hist_ten = extractHistograms( dset, nbins, nchannels )
%EXTRACTHISTOGRAM Extract histograms of images contained in a dataset.
%   HIST_MAT = EXTRACTHISTOGRAM(DSET,NBINS,NCHANNELS) returns a hist_mat
%   tensor which enfolds the histograms of the images contained in the dset
%   dataset, with the selected number of bins and channels.

% TODO: CHECK INPUT

% Preallocate hist_ten tensor.
hist_ten = zeros(nbins, nchannels, size(dset,4), size(dset,5));
% Extract the histogram of the specified channels with the specific number
% of bins.
% TODO: PARFOR/GPU
for i = 1:size(dset,4)
    for j = 1:size(dset,5)
        for k = 1:nchannels
            hist_ten(:,k,i,j) = histcounts(dset(:,:,k,i,j),nbins);
        end
    end
end

end