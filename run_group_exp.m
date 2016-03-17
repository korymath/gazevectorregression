k = dir([pwd '/data/proc/output*.mat']);
files = {k.name}';

for i=1:length(files)
    data{i} = load([pwd '/data/proc/' files{i}] );
    if data{i}.calType == 1
        % sweep
    elseif data{i}.calType == 2
        % grid
    elseif data{i}.calType == 0
        % no segment
    end
end

errDistErr = 