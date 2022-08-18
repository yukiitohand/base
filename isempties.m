function [isemp] = isempties(ar)
% [isemp] = isempties(ar)
%  isempty for the array
%   Input Parameters
%     ar: array (cell, struct, or numeric)
%   Output Parameters
%     isemp: numeric array, the result of isempty for each element.

if iscell(ar)
    isemp = cellfun(@(x) isempty(x), ar);
else
    error('Input is not iscell. Please implement for this case.');
end

end