function [ yq ] = interpGaussConv( x,y,xq,fwhm )
% [ yq ] = interpGaussian( x,y,xq,fwhm )
%   interpolation using Gaussian convolution
%   Input Parameters
%       x    : [L x 1], samples for original data
%       y    : [L x N], data for original samples, N: #of data
%       xq   : [Lq x 1], queried samples.
%       fwhm : [Lq x 1] or scalar, full width half maximum of each queried samples
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
if Lqfwhm==1
    fwhm = ones([Lq,1])*fwhm;
else
    if Lq~=Lqfwhm
         error('size of xq and fwhm does not match');
    end   
end
x = x(:); xq = xq(:); fwhm = fwhm(:);

% covert fwhm to sigma
sigma = fwhm2sigma(fwhm);

yq = zeros([Lq,N]);
% for i =1:Lq
%     c = normpdf(x,xq(i),sigma);
%     c_sum = sum(c);
%     yq(i,:) = sum(bsxfun(@times,c,y),1) /c_sum;
% end


% compute approximate width of the wvspc
x_extend = zeros([Lspc+2,1]);
x_extend(2:end-1) = x;
x_extend(1) = 2*x(1)-x(2);
x_extend(end)=2*x(end)-x(end-1);
x_between = (x_extend(2:end) + x_extend(1:end-1))/2;
x_bd = x_between(2:end) - x_between(1:end-1);


for i =1:Lq
    c = normpdf(x,xq(i),sigma) .* x_bd;
    Z = sum(c);
    yq(i,:) = sum(bsxfun(@times,c,y),1) / Z;
end

end

