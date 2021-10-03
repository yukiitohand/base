function [flg_reproc] = doyouwanttoprocess(filepath,force,load_cache_ifexist)
% [flg_reproc] = doyouwanttoprocess(cachepath,force,load_cache_ifexist)
%  get a flag that tells 
if force
    flg_reproc = true;
else
    if ischar(filepath)
        exist_flg = exist(filepath,'file');
    elseif iscell(filepath)
        exist_flg = all(cellfun(@(x) exist(x,'file'),filepath));
    else
        error('Something wrong with filepath.');
    end
    if exist_flg
        if load_cache_ifexist
            flg_reproc = false;
        else
            if ischar(filepath)
                firstsentence = sprintf('%s exists',filepath);
            elseif iscell(filepath)
                firstsentence = sprintf('Following file(s) exist:\n');
                for i=1:length(filepath)
                    firstsentence = [firstsentence sprintf('%s\n',filepath{i})];
                end
                firstsentence = firstsentence(1:end-1);
            end
            [flg_reproc] = doyouwantto('reprocess',firstsentence);
        end
    else
        flg_reproc = true;
    end
end

end