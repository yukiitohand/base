function [ ar_thed,lowhigh,is_extrm_mask ] = hard_percentile_thresholding( ar,tol )
% round lowest and highest (tol)*100 [%] values in its percentile
% Inputs
%    ar: array
%    tol: scalar (<1.0) or 1x2 array (tol(1)+tol(2)<1.0). Percentile tolerance. 
%       with numel(tol) = 1
%          Extremeness of values is evaluated by the absolute deviation 
%          from the median value of the array. The deviation is sorted by
%          the deviation and the values larger than tol*100 percentile are 
%          rounded up/down, depending on high or low extremness.
%       with numel(tol) = 2,
%          Values smaller than that of tol(1)*100 percentile are rounded up
%          to that of tol(1)*100 percentile
%          Values larger than that of (1-tol(2))*100 percentile are rounded
%          down to that of (1-tol(2))*100 percentile
% Outputs
%    ar_thed: rounded array, same size as ar.
%    lowhigh: 1 x 2 array, the first element is the minimum and the second
%    element is the maximum of the ar_thed.
%    is_extrm_mask: boolean, same size as ar. True if a value has an 
%        extreme value, false otherwise.

if sum(tol) > 1.0, error('Tolis too large.'); end

ar2 = ar(:);

if isscalar(tol)
    ar2_med = median(ar2,'omitnan');
    [ V,I,R ] = nansort1d(abs(ar2-ar2_med),'ascend');
elseif numel(tol) == 2
    [ V,I,R ] = nansort1d(ar2,'ascend');
else
    error('The shape of tol is not right.');
end

if isempty(I)
    ar_thed = ar;
    is_extrm_mask = false(size(ar));
    lowhigh = nan([1,2]);
elseif isscalar(tol)
    is_extrm_mask = false(size(ar2));
    N = length(I);
    high_idx = ceil(N*(1-tol)+0.5);
    % if high_idx>N, high_idx = N; end
    
    indx_extrm = I(high_idx:end);
    is_extrm_indx_high = (ar2(indx_extrm)-ar2_med) > 0;
    indx_high_extrm = indx_extrm( is_extrm_indx_high );
    indx_low_extrm  = indx_extrm( ~is_extrm_indx_high );
    
    ar2(indx_extrm) = nan;
    low  = min(ar2,[],1,'omitnan');
    high = max(ar2,[],1,'omitnan');
    
    ar2(indx_low_extrm) = low;
    ar2(indx_high_extrm) = high;
    is_extrm_mask(indx_extrm) = true;
    
    ar_thed = reshape(ar2,size(ar));
    is_extrm_mask = reshape(is_extrm_mask,size(ar));
    
    lowhigh = [low high];
    
elseif numel(tol) == 2
    is_extrm_mask = false(size(ar2));
    N = length(I);

    low_idx = ceil(N*tol(1));
    high_idx = floor(N*(1-tol(2)));
    
    if low_idx<1, low_idx = 1; end
    ar2(I(1:low_idx)) = V(low_idx);
    is_extrm_mask(I(1:low_idx)) = true;
    
    if high_idx>N, high_idx = N; end
    ar2(I(high_idx:end)) = V(high_idx);
    is_extrm_mask(I(high_idx:end)) = true;

    ar_thed = reshape(ar2,size(ar));
    is_extrm_mask = reshape(is_extrm_mask,size(ar));
    
    lowhigh = [V(low_idx) V(high_idx)];
    
end



end
