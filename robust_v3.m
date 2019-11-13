function [ vals,outliers ] = robust_v3(func,data,dim,varargin )
% [ val ] = robust_v3(func, data,dim,varargin )
%   perform 'func' by removing n_exclu extreme points. Extreme points are
%   selected based on median subtraction
%   possible choice for 'func' is {'mean','var','std','stdl1',...
%     'mean_abs_dev_from_mean','mean_abs_dev_from_med','med_abs_dev_from_mean',...
%     'med_abs_dev_from_med'}
%   Optional parameters
%   'NOUTLIERS': scalar or (vector, not implemented yet)
%   'OUTLIERS': boolean matrix, same size as the data
%   'SIDE'    : {'large', 'small', 'both'}
%               the side from which outliers are taken
%               (default) 'both'
%               currently, 'both' is the only option implemented

Noutliers_default = 10;
outliers_default = [];
side_default = 'large';

p = inputParser();
addRequired(p,'func',@(x) any(validatestring(x,{'mean','var','std','stdl1',...
    'mean_abs_dev_from_mean','mean_abs_dev_from_med','med_abs_dev_from_mean',...
    'med_abs_dev_from_med'},mfilename,'func')));
addRequired(p,'data',@(x) validateattributes(x,{'numeric'},{'nonempty'},mfilename,'data'));
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

[L,M,N] = size(data);
if ~isempty(outliers) 
    validateattributes(outliers,{'logical'},{'size',[L,M,N]},mfilename,'Outliers');
    outlier_mode = true; % 0 indicates the number based, 1 indiates the index based.
else
    outlier_mode = false;
end
if ~any(dim == [1,2,3])
    error('Dim is invalid');
end

%%
if outlier_mode==0
    [datasub,datamedian] = submedian(data,dim);
    [datasubSorted,idatasubSorted] = sort(abs(datasub),dim,'descend',...
               'MissingPlacement','last'); % nan will be ignored.
    outliers = false(size(data));
    if length(Noutliers)==1
        if dim==1
            for m=1:M
                for n=1:N
                    outliers(idatasubSorted(1:Noutliers,m,n),m,n) = true;
                end
            end
        elseif dim==2
            for l=1:L
                for n=1:N
                    outliers(l,idatasubSorted(l,1:Noutliers,n),n) = true;
                end
            end
        elseif dim==3
            for l=1:L
                for m=1:M
                    outliers(l,m,squeeze(idatasubSorted(l,m,1:Noutliers))) = true;
                end
            end
        end
    else
        error('not implemented yet');
    end
    
end

data(outliers) = nan;
switch lower(func)
    case 'mean'
        vals = nanmean(data,dim);
    case 'std'
        vals = nanstd(data,[],dim);
    case 'var'
        vals = nanvar(data,[],dim);
    case {'stdl1','mean_abs_dev_from_mean'}
        m = nanmean(data,dim);
        vals = nanmean(abs(data-m),dim);
    case {'mean_abs_dev_from_med'}
        m = nanmedian(data,dim);
        vals = nanmean(abs(data-m),dim);
    case 'med_abs_dev_from_mean'
        m = nanmean(data,dim);
        vals = nanmedian(abs(data-m),dim);
    case 'med_abs_dev_from_med'
        m = nanmedian(data,dim);
        vals = nanmedian(abs(data-m),dim);
    otherwise
        error('func is invalid');
end

end