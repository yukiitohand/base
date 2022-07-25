function [ ar_thed,lowhigh ] = hard_percentile_thresholding( ar,tol )
% round lowest and highest (tol)*100 [%] values in its percentile
% Inputs
%    ar: array
%    tol: percentile tolerance
% Outputs
%    ar_thed: rounded array

if isscalar(tol)
    tol = [tol tol];
end

if sum(tol) > 1.0
    error('Tolis too large.');
end

ar2 = ar(:);
[ V,I,R ] = nansort1d(ar2,'ascend');
if isempty(I)
    ar_thed = ar;
    lowhigh = nan([1,2]);
else
    N = length(I);

    low_idx = ceil(N*tol(1));
    high_idx = floor(N*(1-tol(2)));
    if low_idx<1
        low_idx = 1;
    end
    ar2(I(1:low_idx)) = V(low_idx);
    
    if high_idx>N
        high_idx = N;
    end
    ar2(I(high_idx:end)) = V(high_idx);

    ar_thed = reshape(ar2,size(ar));
    
    lowhigh = [V(low_idx) V(high_idx)];
    
end



end
