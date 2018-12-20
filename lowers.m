function [str_l] = lowers(ar)
% [str_l] = lowers(ar)
%  lower for a cell array
%   Input Parameters
%     ar: a cell array
%   Output Parameters
%     str_l: cell array, the result of lower for each element.

if iscell(ar)
    str_l = cellfun(@(x) lower(x), ar,'UniformOutput',false);
else
    error('Input is not iscell. Please implement for this case.');
end

end