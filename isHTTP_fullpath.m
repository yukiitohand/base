function [ishttpfull] = isHTTP_fullpath(p)
% [ishttpfull] = isHTTP_fullpath(p)
%   evaluate the input is a http full path or not
% Input
%   p: path, string
% Output
%   ishttpfull: boolean,

ptrn_fullpath = '^http://.+';

ishttpfull = ~isempty(regexpi(p,ptrn_fullpath,'ONCE'));

end