function [ yq ] = normpdf_r( xq,mu,sigma,normalize_on)
% [ yq ] = normpdf_r( xq,mu,sigma,normalize_on )
%   rough version of normpdf
%   Input Parameters
%       xq   : [L x 1] or [1 x L], queried samples for original data
%       mu   : center of gaussian
%       sigma: standard deviation of gaussian
%       normalize_on : whether or not to normalize the histgram
%   Output Parameters
%       yq   : [L x 1] or [1 x L] (up to the shape of xq)

[L1,L2] = size(xq);

if L1==1 && L2>1
    is_rowvec = true;
elseif L1>1 && L2==1
    is_rowvec = false;
else
    error('Only 1-dimensional xq is accepted');
end

L = length(xq);

% compute approximate width of the wvspc
x_extend = zeros([L+2,1]);
x_extend(2:end-1) = xq;
x_extend(1) = 2*xq(1)-xq(2);
x_extend(end)=2*xq(end)-xq(end-1);
x_between = (x_extend(2:end) + x_extend(1:end-1))/2;
% x_bd = x_between(2:end) - x_between(1:end-1);

c = normcdf(x_between,mu,sigma);

yq = c(2:end) - c(1:end-1);

if normalize_on
    yq = yq./ sum(yq);
end

if is_rowvec
    yq = yq';
end

end