function [ im_showed,crange ] = scx_rgb( varargin )
% complimentary version of the function sc for more customized rgb viewing
%   Inputs
%       im: image [M x N x 1] or [M x N x 3]
%       method: method for image stretching, currently 'linear' is only
%       supported
%       tol: tolearnce based on the percentile
%       
%   Optional Parameters
%       passed to the function sc
%   Outputs
%       imshowed: the [0-255] rgb image shown in the figure ready to be saved
%       crange: color range [1 x 2] or [3 x 2]
%               each of the row contains [minv, maxv] for the channel
%   Usage
%       scx_rgb(im,varargin)
%       scx_rgb(im,crange,varargin)
%       scx_rgb(im,method,tol,varargin) % not supported yet
%       scx_rgb(ax,im,varargin)
%       scx_rgb(ax,im,crange,varargin)
%       scx_rgb(ax,im,method,tol,varargin) % not supported yet

method = 'linear';
tol = 0.001;
ax_ori = gca;
crange = [];

if isa(varargin{1},'matlab.graphics.axis.Axes')
    ax = varargin{1};
    axes(ax);
    im = varargin{2};
    
    if length(varargin)>2
        if all(size(varargin{3}) == [size(im,3),2])
            crange = varargin{3};
            if length(varargin)>3
                varargin = varargin{4:end};
            else
                varargin = {};
            end
        else
            if length(varargin)>2
                varargin = varargin{3:end};
            else
                varargin = {};
            end
        end
    else
        varargin = {};
    end
else
    ax = gca;
    im = varargin{1};
    if length(varargin)>1
        if all(size(varargin{2}) == [size(im,3),2])
            crange = varargin{2};
            if length(varargin)>2
                varargin = varargin{3:end};
            else
                varargin = {};
            end
        else
            if length(varargin)>1
                varargin = varargin{2:end};
            else
                varargin = {};
            end
        end
    else
        varargin = {};
    end
end

[ im_stretched ] = im_hard_percentile_thresholding( im,tol );

switch method
    case 'linear'
        [im_showed,crange] = im_lstretch(im_stretched,crange);
        if nargout>1
            % sc(im_showed,varargin{:});
        else
            sc(im_showed,varargin{:});
        end
    otherwise
        error('input method is not supported');
end

hdt = datacursormode(gcf);
set(hdt,'UpdateFcn',{@map_cursor_Orivalue,im});


% axes(ax_ori);

end

function output_txt = map_cursor_Orivalue(obj,event_obj,CData)
% Display the position of the data cursor
% obj          Currently not used (empty)
% event_obj    Handle to event object
% output_txt   Data cursor text string (string or cell array of strings).

pos = get(event_obj,'Position');
output_txt = {['X: ',num2str(pos(1),4)],...
    ['Y: ',num2str(pos(2),4)],['Val: ' num2str(CData(pos(2),pos(1),:))]};

% % If there is a Z-coordinate in the position, display it as well
% if length(pos) > 2
%     output_txt{end+1} = ['Z: ',num2str(pos(3),4)];
% end

end