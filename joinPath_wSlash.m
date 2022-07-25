function [cmbpth] = joinPath_wSlash(varargin)
% [cmbpth] = joinPath_wSlash(varargin)
%   join the path with slash
%   Usage
%     [cmbpth] = joinPath(path1,path2,path3,...)
%   The output is the combined path 'path1/path2/path3', If path# has '/'
%   at the end, the slash won't be added.

L = length(varargin);
cmbpth = [];
for i=1:L-1
    pathi = complementSlash(varargin{i});
    cmbpth = [cmbpth pathi];
end
cmbpth = [cmbpth varargin{L}];

end