function [ vals,outliers ] = robust(func,data,dim,varargin )
% [ val ] = robust(func, data,dim,varargin )
%   perform 'func' by removing n_exclu extreme points
%   possible choice for 'func' is {'mean','var','std'}
%   Optional parameters
%   'NOUTLIERS': scalar or vector
%   'OUTLIERS': boolean matrix, same size as the data
%   'SIDE'    : {'large', 'small', 'both'}
%               the side from which outliers are taken
%               (default) 'both'
%               currently, 'both' is the only option implemented

Noutliers_default = 10;
outliers_default = [];
side_default = 'large';

p = inputParser();
addRequired(p,'func',@(x) any(validatestring(x,{'mean','var','std','stdl1'},mfilename,'func')));
addRequired(p,'data',@(x) validateattributes(x,{'numeric'},{'2d','nonempty'},mfilename,'data'));
addRequired(p,'dim',@(x) validateattributes(x,{'numeric'},{'scalar'},mfilename,'dim'));
addParameter(p,'NOutliers',Noutliers_default,@(x) validateattributes(x,{'numeric'},...
    {'nonnegative','integer'},mfilename,'NOutliers'));
addParameter(p,'Outliers',outliers_default,@(x) validateattributes(x,{'logical','numeric'},mfilename,'Outliers'));
addParameter(p,'Side',side_default,@(x) validatestring(x,{'large','small','both'},mfilename,'Side'));

parse(p,func,data,dim,varargin{:});
func = p.Results.func;
data = p.Results.data;
dim  = p.Results.dim;
Noutliers = p.Results.NOutliers;
outliers = p.Results.Outliers;
side = p.Results.Side;

if ~isempty(outliers) 
    [L,N] = size(data);
    validateattributes(outliers,{'logical'},{'size',[L,N]},mfilename,'Outliers');
    outlier_mode = true; % 0 indicates the number based, 1 indiates the index based.
else
    outlier_mode = false;
end

%% input check
% if (rem(length(varargin),2)==1)
%     error('Optional parameters should always go by pairs');
% else
%     for i=1:2:(length(varargin)-1)
%         switch upper(varargin{i})
%             case 'NOUTLIERS'
%                 Noutliers = varargin{i+1};               
%             case 'OUTLIERS'
%                 outliers = varargin{i+1};
%                 if ~islogical(outliers)
%                     error('OUTLIERS must be boolean type.');
%                 end
%                 if (size(outliers,1)~=size(data,1)) || (size(outliers,2)~=size(data,2)) 
%                     error('Outliers must be the same size as data');
%                 end
%                 outlier_mode = 1;
%             case 'SIDE'
%                 side = varargin{i+1};
%                 if ~strcmpi(side,'both')
%                     error('side=%s is not implemented yet',side);
%                 end
%             otherwise
%                 % Hmmm, something wrong with the parameter string
%                 error(['Unrecognized option: ''' varargin{i} '''']);
%         end
%     end
% end

% if size(data,3)>1
%     error('only 2 dimensional data is supported.');
% end

if (dim~=1) && (dim~=2)
    error('Dim is invalid');
end

if length(Noutliers)>1
    if dim==1
        if size(Noutliers,2)~=size(data,2)
            error('Size of Noutliers is invalid');
        end
    elseif dim==2
        if size(Noutliers,1)~=size(data,1)
            error('Size of Noutliers is invalid');
        end
    end
end

if outlier_mode==0
    [datasub,datamean] = submean(data,dim);
%     if dim==1
%         val = zeros([1,size(datasub,2)]);
%     elseif dim==2
%         val = zeros([size(datasub,1),1]);
%     else
%         error('dim>3 is not supported');
%     end

    [datasubSorted,idatasubSorted] = sort(abs(datasub),dim,'descend');
    outliers = false(size(data));
    if length(Noutliers)==1
        if dim==1
            for i=1:size(data,2)
                outliers(idatasubSorted(1:Noutliers,i),i) = true;
            end
        elseif dim==2
            for i=1:size(data,1)
                outliers(i,idatasubSorted(i,1:Noutliers)) = true;
            end
        end
    else
        if dim==1
            for i=1:size(data,2)
                outliers(idatasubSorted(1:Noutliers(i),i),i) = true;
            end
        elseif dim==2
            for i=1:size(data,1)
                outliers(i,idatasubSorted(i,1:Noutliers(i))) = true;
            end
        end
    end
    
end

data(outliers) = nan;
if strcmpi(func,'mean')
    vals = nanmean(data,dim);
elseif strcmpi(func,'std')
    vals = nanstd(data,[],dim);
elseif strcmpi(func,'var')
    vals = nanvar(data,[],dim);
elseif strcmpi(func,'stdl1')
    m = nanmean(data,dim);
    vals = nanmean(abs(data-m),dim);
else
    error('func is invalid');
end

end

