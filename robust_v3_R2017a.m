function [ vals,outliers,varargout ] = robust_v3_R2017a(func,data,dim,varargin )
% [ val ] = robust_v3_R017a(func, data,dim,varargin )
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
data_center_default = [];

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
addParameter(p,'Data_Center',data_center_default,@(x) validateattributes(x,{'numeric'},{},mfilename,'Data_Center'));

parse(p,func,data,dim,varargin{:});
func = p.Results.func;
data = p.Results.data;
dim  = p.Results.dim;
Noutliers = p.Results.NOutliers;
outliers = p.Results.Outliers;
side = p.Results.Side;
data_center = p.Results.Data_Center;

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

Nd = ndims(data);
dim_permute = 1:Nd;

if dim~=1
    dim_permute(dim) = 1;
    dim_permute(1) = dim;
    data = permute(data,dim_permute);
end


%%
if outlier_mode==0
    if isempty(data_center)
        [datasub,datamedian] = submedian(data,1);
    else
        datasub = data - data_center;
    end
     % nan will be ignored.
    %
    
    
    % outliers = false(size(data));
    if length(Noutliers)==1
        [~,idatasubSorted] = sort(-abs(datasub),1,'descend');
        % The above just try to put NaNs at the end.
        indstruct = substruct('()',[1:Noutliers,repmat({':'},1,Nd-1)]);
        idatasubSorted = subsref(idatasubSorted,indstruct);
        % [datasubSorted,idatasubSorted] = maxk(abs(datasub),Noutliers,1);
        sz_outlierind = size(idatasubSorted);
        II = cell(1,Nd);
        II{1} = idatasubSorted;
        for i=2:Nd
            sz_idx = ones(1,Nd);
            sz_idx(i) = sz_outlierind(i);
            II{i} = ones(sz_outlierind) .* reshape(1:sz_outlierind(i),sz_idx);
        end
        outlierind = sub2ind(size(data),II{:});
        outliers = false(size(data));
        outliers(outlierind(:)) = true;

        % outliers = (idatasubSorted < (Noutliers+1));
%         for m=1:M
%             for n=1:N
%                 outliers(idatasubSorted(1:Noutliers,m,n),m,n) = true;
%             end
%         end
%         if dim==1
%             for m=1:M
%                 for n=1:N
%                     outliers(idatasubSorted(1:Noutliers,m,n),m,n) = true;
%                 end
%             end
%         elseif dim==2
%             for l=1:L
%                 for n=1:N
%                     outliers(l,idatasubSorted(l,1:Noutliers,n),n) = true;
%                 end
%             end
%         elseif dim==3
%             for l=1:L
%                 for m=1:M
%                     outliers(l,m,squeeze(idatasubSorted(l,m,1:Noutliers))) = true;
%                 end
%             end
%         end
    else
        error('not implemented yet');
    end
    
end

data(outliers) = nan;
switch lower(func)
    case 'mean'
        vals = nanmean(data,1);
    case 'std'
        vals = nanstd(data,[],1);
    case 'var'
        vals = nanvar(data,[],1);
    case {'stdl1','mean_abs_dev_from_mean'}
        m = nanmean(data,dim);
        vals = nanmean(abs(data-m),1);
        if dim~=1
            m = permute(m,dim_permute);
        end
        varargout{1} = m;
    case {'mean_abs_dev_from_med'}
        m = nanmedian(data,1);
        vals = nanmean(abs(data-m),1);
        if dim~=1
            m = permute(m,dim_permute);
        end
        varargout{1} = m;
    case 'med_abs_dev_from_mean'
        m = nanmean(data,1);
        vals = nanmedian(abs(data-m),1);
        if dim~=1
            m = permute(m,dim_permute);
        end
        varargout{1} = m;
    case 'med_abs_dev_from_med'
        m = nanmedian(data,1);
        vals = nanmedian(abs(data-m),1);
        if dim~=1
            m = permute(m,dim_permute);
        end
        varargout{1} = m;
    otherwise
        error('func is invalid');
end

if dim~=1
    vals = permute(vals,dim_permute);
end

end