function [isfull] = isfullpath(p)
% [isfull] = isfullpath(p)
%   evaluate the path is a full path or not
%  INPUT
%   p: string, path
%  OUTPUT
%   isfull: logical, 1 if p is a fullpath, 0 if not.
%   

if ispc
    ptrn = '^[A-Z]{1}:.*$';
elseif isunix
    ptrn = '^/.*$';
else
    error('Unknown machine type, supports pc and unix (including mac).');
end

isfull = ~isempty(regexpi(p,ptrn,'Once'));


end

