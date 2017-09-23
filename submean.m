function [ Asub,Amean ] = submean( A,varargin )
%[ Asub,Amean ] = submean( A,varargin )
%   subtract mean from the data
%   currently, only 2-dimensional matrix is supported.
%
%   Usage
%     [Asub,Amean] = submean(A);
%     [Asub,Amean] = submean(A,dim);
%
%   Inputs
%     A: data,
%     dim: dimension for which the mean is taken 
%          (default) 2
%   Outputs
%     Asub: mean subtracted data
%     Amean: the mean spectrum
dim = 2;

if length(varargin)==1
    dim = varargin{1};
elseif length(varargin)>1
    error('Too many input parameters');
end

Amean = nanmean(A,dim);
Asub = bsxfun(@minus,A,Amean);

end

