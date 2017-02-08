function [ Anrmed, stats ] = normalizevec( A,varargin )
%% --------------- Description --------------------------------------------
%[ Anrmed, ] = nromalize( A,dim,varargin )
%   Normalize a matrix A for a specific dimension 
%   Inputs
%       A: a matrix or a vector 
%       dim: dimension along wich the given matrix is normalized
%   Outputs
%       Anrmed: normalized A
%       stats: store mean or norm information
%       stats.mean, stats.norm
%
%% --------------- Optional inputs ----------------------------------------
%
%  'MEANOUT' = {true, false}; subtract the mean of each vector
%              Default false
%
%  'NORMTYPE'  = {inf,-inf,positive integer} specify the norm type for
%                which to normalize vectors
%              Default 2
%
%%
%--------------------------------------------------------------------------
% Set the defaults for the optional parameters
%--------------------------------------------------------------------------
% dimension to be normalized
dim = 1;
% mean out operation
meanout = false;
% define norm type
normtype = 2;

[p,N] = size(A);
% if A is just a vector
if p==1
    dim=2;
elseif N==1
    transposeCnd = false;
    dim=1;
end

if isnumeric(varargin{1})
    dim = varargin{1};
    strtcounter=2;
else
    strtcounter=1;
end

if (rem(length(varargin(strtcounter:end)),2)==1)
    error('Optional parameters should always go by pairs');
else
    for i=strtcounter:2:(length(varargin)-1)
        switch upper(varargin{i})
            case 'DIM'
                dim = varargin{i+1};
            case 'MEANOUT'
                meanout = varargin{i+1};
            case 'NORMTYPE'
                normtype = varargin{i+1};
            otherwise
                % Hmmm, something wrong with the parameter string
                error(['Unrecognized option: ''' varargin{i} '''']);
        end;
    end
end

stats = [];
if meanout
    Amean = mean(A,dim);
    A = bsxfun(@minus,A,Amean);
    stats.mean = Amean;
end

Anrm = vnorms(A,dim,normtype);
Anrmed = bsxfun(@rdivide,A,Anrm);
stats.norm = Anrm;

end

