% TODO: check struct coherence
fields = fieldnames(stat1);

% TODO: preallocate
v1 = [];
v2 = [];
v3 = [];
l1 = [];
l2 = [];
l3 = [];

for i = 1:numel(fields)
    for j = 1:632
        % TODO: remove hardcoded values
        % TODO: probably mean is biased
        v1 = [v1; stat1.(fields{i})(2:4,1,j)];
        v1 = [v1; stat2.(fields{i})(2:4,1,j)];
        v2 = [v2; stat1.(fields{i})(2:4,2,j)];
        v2 = [v2; stat2.(fields{i})(2:4,2,j)];
        v3 = [v3; stat1.(fields{i})(2:4,3,j)];
        v3 = [v3; stat2.(fields{i})(2:4,2,j)];
        % TODO: insert labels; parametrize labels 'ones'
        l1 = [l1; j*ones(3*2,1)];
    end
end