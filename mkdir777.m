function [status,status777] = mkdir777(dirpath,varargin)
% [status,status777] = mkdir777(dirpath)
% [status,status777] = mkdir777(dirpath,verbose)
%   Create a directory and chmod to 777. Raise an error if mkdir is not
%   successful, return status777=0 if chmod777 is not successful
% INPUTS
%   dirpath: path to the directory
%   verbose: boolean, whetner or not to print results.s
% OUTPUTS
%   status    : boolean 1 if mkdir successful, 0 not
%   status777 : boolean 1 if chmod777 successful, 0 not
%

if isempty(varargin)
    verbose = false;
elseif length(varargin)==1
    verbose = varargin{1};
else
    error('Too many inputs.');
end

if exist(dirpath,'dir')
    status      = 1;
    [status777] = chmod777(dirpath,verbose);
else
    [status,msg] = mkdir(dirpath);
    if status
        if verbose, fprintf('"%s" is created.\n',dirpath); end
        [status777,msg] = chmod777(dirpath,verbose);
    else
        status777 = 0;
        error('Failed to create %s:\n %s',dirpath,msg);
    end
end

end