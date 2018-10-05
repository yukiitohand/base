function [ ar_thed ] = hard_percentile_thresholding( ar,tol )
% round lowest and highest (tol)*100 [%] values in its percentile
% Inputs
%    ar: array
%    tol: percentile tolerance
% Outputs
%    ar_thed: rounded array
ar2 = ar(:);
[ V,I,R ] = nansort1d(ar2,'ascend');
if isempty(I)
    ar_thed = ar;
else
    N = length(I);

    low_idx = ceil(N*tol);
    high_idx = floor(N*(1-tol));
    if low_idx>0
        ar2(I(1:low_idx)) = V(low_idx);
    end
    if high_idx<length(ar2)
        ar2(I(high_idx:end)) = V(high_idx);
    end

    ar_thed = reshape(ar2,size(ar));
end

end
