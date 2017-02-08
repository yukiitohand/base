function [ V,idx2 ] = max2d( X )
% compute max values and its 2-d index of the 2-D matrix
%   Inputs
%     X : 2-d matrix
%   Outputs
%     V : the max value
%     idx2 : (ind1,ind2) X[idx(1), idx(2)] is the position for the max
%     value.

if length(size(X))~=2
    error('The shape of X is not correct\n');
end

[v,idx] = max(X,[],1);
[V,ind2] = max(v,[],2);
ind1 = idx(ind2);

idx2 = [ind1 ind2];


end

