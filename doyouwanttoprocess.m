function [flg_reproc] = doyouwanttoprocess(cachepath,force,load_cache_ifexist)
% [flg_reproc] = doyouwanttoprocess(cachepath,force,load_cache_ifexist)
%  get a flag that tells 
if force
    flg_reproc = true;
else
    if exist(cachepath,'file')
        if load_cache_ifexist
            flg_reproc = false;
        else
            [flg_reproc] = doyouwantto('reprocess',sprintf('%s exists',cachepath));
        end
    else
        flg_reproc = true;
    end
end

end