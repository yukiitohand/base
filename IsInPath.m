function [ flg ] = IsInPath( p )
% [ flg ] = IsInPath( p )
%   check if "p" is in the matlab search path or not
%   Input:
%     p: string, relative path or absolute path
%   Output:
%     flg: Boolean, true if p is in the path otherwise false

% if the given path is not the folder, then give an error.
if exist(p)~=7
    error('The path "p" does not exist or is not a folder.');
end

% remove the slash at the end of the path if p has
if strcmp(p(end),'/')
    p = p(1:end-1);
end


% convert relative path to absolute path
if ispc
    error('Not implemented yet');
    % isrelative = isempty(regexp(p,'^[A-Za-z]{1}:\\.*'));
else
    isrelative = isempty(regexp(p,'^/.*'));
end

if isrelative
    abspath = fullfile(pwd,p);
else
    abspath = p;
end

% search through the path
pathList = path;
sep = pathsep;
if verLessThan('matlab','8.1')
    error('This is not supported for the version before R2013a');
else
    pathList = strsplit(pathList,sep);
end

flg = any(strcmp(abspath,pathList));

end

