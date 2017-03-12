function [ yq ] = interpGaussConv( x,y,xq,fwhm )
% [ yq ] = interpGaussian( x,y,xq,fwhm )
%   interpolation using Gaussian convolution
%   Input Parameters
%       x    : [L x 1], samples for original data
%       y    : [N x L], data for original samples, N: #of data
%       xq   : [Lq x 1], queried samples.
%       fwhm : [Lq x 1], full width half maximum of each queried samples
%   Output Parameters
%       yq   : [Lq x N]

if ~isvector(x) || ~isnumeric(x)
    error('x must be a numeric vector');
end

if ~isvector(xq) || ~isnumeric(xq)
    error('xq must be a numeric vector');
end

if ~isvector(fwhm) || ~isnumeric(fwhm)
    error('xq must be a numeric vector');
end

L = length(x);
[Ly,N] = size(y);

if L~=Ly
    error('size of x and y does not match');
end

Lq = length(xq); Lqfwhm = length(fwhm);
if Lq~=Lqfwhm
     error('size of xq and fwhm does not match');
end   

x = x(:); xq = xq(:); fwhm = fwhm(:);

% covert fwhm to sigma
sigma = fwhm2sigma(fwhm);

yq = zeros([Lq,N]);
for i =1:Lq
    c = normpdf(x,xq(i),sigma);
    c_sum = sum(c);
    yq(i,:) = sum(bsxfun(@times,c,y),1) /c_sum;
end

end

