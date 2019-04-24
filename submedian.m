function [ Asub,Amedian ] = submedian( A,varargin )
%[ Asub,Amedian ] = submedian( A,varargin )
%   subtract median from the data
%   currently, only 2-dimensional matrix is supported.
%
%   Usage
%     [Asub,Amedian] = submedian(A);
%     [Asub,Amedian] = submedian(A,dim);
%
%   Inputs
%     A: data,
%     dim: dimension for which the mean is taken 
%          (default) 2
%   Outputs
%     Asub: median subtracted data
%     Amedian: the median spectrum
dim = 2;

if length(varargin)==1
    dim = varargin{1};
elseif length(varargin)>1
    error('Too many input parameters');
end

Amedian = nanmedian(A,dim);
Asub = bsxfun(@minus,A,Amedian);

end