function isStructOk = helperChkDsetStruct(dataset, expectedDatasetFields)
%HELPERCHKDSETSTRUCT Check the structure of the dataset.
%   ISSTRUCTOK = HELPERCHKDSETSTRUCT(DATASET) returns true if the structure
%   DATASET has both fields probeSet and gallerySet, returns false
%   otherwise.

%TODO INPUT PARSER + DOCS

datasetFields = fieldnames(dataset, '-full');
if ~isequal(datasetFields, expectedDatasetFields)
    isStructOk = false;
else
    isStructOk = true;
end

end

