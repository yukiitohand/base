function [ V,I,R ] = nansort1d( ar,varargin )
% [ V,I,R ] = nansort( ar,varargin )
%  sort numbers while ignoring nan values
%    Inputs
%      ar: one dimensional array
%   Optional Parameters
%      drc: {'ascend' or 'descend'}. by default, 'ascend'
%   Outputs
%      V: sorted vector.
%      I: indices arranged to the sorted vector.
%      R: ranking of each element
%    Usage
%       [ V,I ] = nansort( ar )
%       [ V,I ] = nansort( ar,'descend' )

if ~isvector(ar)
    error('ar must be a vector.');
end

drc = 'ascend';
if length(varargin)==1
    drc = varargin{1};
elseif length(varargin)>1
    error('Too many input parameters');
end


idx=~isnan(ar);
idx2 = find(idx);
N = length(idx2);

[v,i] = sort(ar(idx),drc);
r = zeros(N,1);
r(i) = 1:N;

% V = nan(size(ar)); 
R = nan(size(ar));

V = v; I = idx2(i);

R(idx) = r;

end

