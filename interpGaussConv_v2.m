function [ yq ] = interpGaussConv_v2( x,y,xq,fwhm,varargin )
% [ yq ] = interpGaussian_v2( x,y,xq,fwhm )
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

retainratio = 0.9;

if (rem(length(varargin),2)==1)
    error('Optional parameters should always go by pairs');
else
    for i=1:2:(length(varargin)-1)
        switch upper(varargin{i})
            case 'RETAINRATIO'
                retainratio = varargin{i+1};
            otherwise
                error('Undefined option:%s.',upper(varargin{i}));
        end
    end
end



% covert fwhm to sigma
sigma = fwhm2sigma(fwhm);

yq = nan(Lq,N);
% for i =1:Lq
%     c = normpdf(x,xq(i),sigma);
%     c_sum = sum(c);
%     yq(i,:) = sum(bsxfun(@times,c,y),1) /c_sum;
% end

y_notisnan = ~isnan(y);
for i =1:Lq
    c = normpdf_r(x,xq(i),sigma(i),false);
    Z = nansum(c.*y_notisnan,1);
    valid_idx = Z > retainratio;
    yq(i,valid_idx) = nansum(bsxfun(@times,c(:,valid_idx),y(:,valid_idx)),1) ./ Z(:,valid_idx);
end

end