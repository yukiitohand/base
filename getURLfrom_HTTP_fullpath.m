function [url] = getURLfrom_HTTP_fullpath(p)
% [url] = getURLfrom_HTTP_fullpath(p)
%   get url from the full http path including protocol
% Input
%   p: path, string
% Output
%   url: string 

ptrn_fullpath = '^http://(?<url>.+)';

prop = regexpi(p,ptrn_fullpath,'names');

url = prop.url;

end
