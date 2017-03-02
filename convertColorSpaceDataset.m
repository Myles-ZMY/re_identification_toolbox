function convDataset = convertColorSpaceDataset( dataset )
%CONVERTCOLORSPACEDATASET Summary of this function goes here
%   Detailed explanation goes here
fields = fieldnames(dataset, '-full');
for i = 1:numel(fields)
    inputTensor = dataset.(fields{i});
    outputTensor = zeros(size(inputTensor,1), size(inputTensor,2), size(inputTensor,3), size(inputTensor,4));
    for j = 1:size(inputTensor,4)
        outputTensor(:,:,:,j) = rgb2hsv(inputTensor(:,:,:,j));
    end
    convDataset.(fields{i}) = outputTensor;
end

end

