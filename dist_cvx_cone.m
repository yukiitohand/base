function [ dsts,H,e ] = dist_cvx_cone( W,Y )
% [ dsts ] = dist_cvx_cone( W,Y )
%   Inputs
%       W : vertices of the convex cone each column vector correspond to 
%           the vertx. [dim x num of vertices]
%       Y : vectors whose distance you attempt to measure from the cone
%           [dim x num of test vectors]
%   Outputs
%       dsts : distances [1 x num of test vectors]

[dim1,nTest] = size(Y);
[dim2,nVrt] = size(W);

if (dim1~=dim2)
    error('sizes of the matrices does not match.');
else
    dim = dim1;
end

cvx_begin
%     cvx_precision best
    variable H(nVrt,nTest)
    minimize( norm(Y-W*H,'fro'))
    subject to 
        H >= 0
cvx_end

e = Y-W*H;
dsts = sqrt(sum(e.^2,1));

end

