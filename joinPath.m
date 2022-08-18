function [cmbpth] = joinPath(varargin)
% [cmbpth] = joinPath(varargin)
%   join the path with slash
%   Usage
%     [cmbpth] = joinPath(path1,path2,path3,...)

cmbpth = fullfile(varargin{:});

% L = length(varargin);
% cmbpth = [];
% for i=1:L-1
%     pathi = complementSlash(varargin{i});
%     cmbpth = [cmbpth pathi];
% end
% cmbpth = [cmbpth varargin{L}];

end