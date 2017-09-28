function [pnew] = complementSlash(p)
% [pnew] = complementSlash(p)
%   add '/' at the end if there is not
if ~strcmp(p(end),'/')
    pnew = [p '/'];
else
    pnew = p;
end
    

end