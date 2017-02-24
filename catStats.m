% isolate each field in struct stat

fields = fieldnames(stat);

for i = 1:numel(fieldnames(stat))
    % partial result tensor
    partial = stat.(fields{i});
    % for each partial tensor, iterate through second dimension (i.e.
    % isolate channel)
    for j = 1:3
        partialR = squeeze(partial(:,j,:));
        % concatenate partialR with the partials from the other structures
        partialTot = [partialTot; partialR];
    end
end
% as an otput, we should expect a single matrix for each channel
