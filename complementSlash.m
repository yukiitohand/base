function [pnew] = complementSlash(p)
% [pnew] = complementSlash(p)
%   add '/' at the end if there is not

if isempty(p)
    pnew = p;
else
    if strcmp(p(end),'/'), pnew=p; else, pnew = [p '/']; end
end

end