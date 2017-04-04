function y = soft_thresh(x,T)

if ~isscalar(T)
    if size(x,1)==size(T,1) || size(x,2)==size(T,2)
        
    else
        error('The size of inputs does not match.');
    end
end

if verLessThan('matlab','9.1')
    y = sign(x) .* max(bsxfun(@minus,abs(x), T), 0);
else
    y = sign(x) .* max(abs(x) - T, 0);
end

