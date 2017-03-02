function isDsetOk = helperChkDsetStruct(dataset, varargin)
%HELPERCHKDSETSTRUCT Check the structure of the dataset.
%   isDsetOk = HELPERCHKDSETSTRUCT(dataset, varargin) returns true if the
%   fields of dataset structure are equals to the ones specified in the
%   'ExpectedDatasetFields' optional name-value argument, which is a cell
%   array composed by strings, each one which represent the name of a field
%   in the dataset struct. 'ExpectedDatasetFields' members should be passed
%   in the exact order in which the fields are organized in the dataset
%   structure.
%
%   Examples:
%   isDsetOk = HELPERCHKDSETSTRUCT(dataset) returns true if dataset has 
%   the default fields, i.e. probeSet and gallerySet.
%   isDsetOk = HELPERCHKDSETSTRUCT(dataset, {'setA','setB'}') returns true
%   if dataset has both setA and setB fields in that specific order.

p = inputParser;

addRequired(p, 'Dataset', ...
    @(x) assert(isstruct(x), 'It must be a structure.'));
addParameter(p, 'ExpectedDatasetFields', ...
    {'probeSet', 'gallerySet'}, ...
    @(x) assert(iscell(x), 'It must be a cell array.'));

parse(p, dataset, varargin{:});

expectedDatasetFields = p.Results.ExpectedDatasetFields;

% Force expectedDatasetFields to be a column cell vector.
expectedDatasetFields = expectedDatasetFields(:);

datasetFields = fieldnames(dataset, '-full');
if ~isequal(datasetFields, expectedDatasetFields)
    isDsetOk = false;
else
    isDsetOk = true;
end

end