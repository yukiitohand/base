function [str_u] = uppers(ar)
% [str_u] = uppers(ar)
%  upper for a cell array
%   Input Parameters
%     ar: a cell array
%   Output Parameters
%     str_u: cell array, the result of upper for each element.

if iscell(ar)
    str_u = cellfun(@(x) upper(x), ar,'UniformOutput',false);
else
    error('Input is not iscell. Please implement for this case.');
end

end