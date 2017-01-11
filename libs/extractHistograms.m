function exit = extractHistograms( image, channels )
%EXTRACTRGBHISTOGRAM Summary of this function goes here
%   Detailed explanation goes here
%exit = zeros(3);
% extract histograms for all channels
for i = 1:channels
    exit(:,i) = histcounts(image(:,:,i),16);
end

end