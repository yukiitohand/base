function [val_mleq,idx_mleq] = maxleq(ar,val_ref)
%  [val_mleq,idx_mleq] = maxleq(ar,val_ref)
%   find the maximum value less than or equal to a specified value
%   Input Parameters
%     ar: 1-d array
%     val_ref: scalar, value at the upper limit
%   Output Parameters
%     val_mleq: maximum value among the elements less than or equal to
%     val_ref
%     idx_mleq: index for val_mleq

val_mleq = []; idx_mleq = [];
if ~isempty(ar)
    idx_mleq_candidates = find(ar <= val_ref);
    if ~isempty(idx_mleq_candidates)
        [val_mleq,idx_mleq_ptr] = max(ar(idx_mleq_candidates));
        idx_mleq = idx_mleq_candidates(idx_mleq_ptr);
    end
end

end