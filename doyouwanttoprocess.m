function [flg_reproc] = doyouwanttoprocess(filepath,force,skip_ifexist)
% [flg_reproc] = doyouwanttoprocess(cachepath,force,skip_ifexist)
%  get a flag to determine to re-process.
%  INPUTS
%    filepath: char or cell array of char. filepaths to be tested for
%      existence.
%    force: boolean, flg_reproc is always true
%    skip_if_exist: boolean, if all the files are present, return 0. If
%      this is set to false and the files are exist, then you will be asked
%      to continue or stop.
%  OUTPUTS
%    flg_reproc: true/false.

if force
    flg_reproc = true;
else
    if ischar(filepath)
        exist_flg = isfilei(filepath);
        % exist_flg = exist(filepath,'file');
    elseif iscell(filepath)
        exist_flg = all(cellfun(@(x) isfilei(x) ,filepath));
        % exist_flg = all(cellfun(@(x) exist(x,'file'),filepath));
    else
        error('Something wrong with filepath.');
    end
    if exist_flg
        if skip_ifexist
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

function [result] = isfilei(filepath)
% [result] = isfilei(filepath)
% Test the existence of the filepath by case insensitively (only for file
% name). directory path is case sensitive.
[dirpath,bname,ext] = fileparts(filepath);
fname = [bname ext];
fnamei = findfilei(fname,dirpath);
result = ~isempty(fnamei);
end