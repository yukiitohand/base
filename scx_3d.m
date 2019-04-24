function [ im_stretched3D,crange ] = scx_3d( im,tol,varargin )
% complimentary version of the function sc for more customized rgb viewing
%   Inputs
%       im: image [M x N x L] or [M x N x 3]
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
% tol = 0.02;
% ax_ori = gca;
crange = [];
band_default = 1;
band_names = [];

if (rem(length(varargin),2)==1)
    error('Optional parameters should always go by pairs');
else
    for i=1:2:(length(varargin)-1)
        switch upper(varargin{i})
            case 'BAND_NAMES'
                band_names = varargin{i+1};
            otherwise
                % Hmmm, something wrong with the parameter string
                error('Unrecognized option: %s', varargin{i});
        end
    end
end



% if isa(varargin{1},'matlab.graphics.axis.Axes')
% %     ax = varargin{1};
% %     axes(ax);
% %     im = varargin{2};
%     
%     if length(varargin)>2
%         if all(size(varargin{3}) == [size(im,3),2])
%             crange = varargin{3};
%             if length(varargin)>3
%                 varargin = varargin{4:end};
%             else
%                 varargin = {};
%             end
%         else
%             if length(varargin)>2
%                 varargin = varargin{3:end};
%             else
%                 varargin = {};
%             end
%         end
%     else
%         varargin = {};
%     end
% else
% %     ax = gca;
%     im = varargin{1};
%     if length(varargin)>1
%         if all(size(varargin{2}) == [size(im,3),2])
%             crange = varargin{2};
%             if length(varargin)>2
%                 varargin = varargin{3:end};
%             else
%                 varargin = {};
%             end
%         else
%             if length(varargin)>1
%                 varargin = varargin{2:end};
%             else
%                 varargin = {};
%             end
%         end
%     else
%         varargin = {};
%     end
% end

[L,S,B] = size(im);

im_stretched3D = nan([L,S,B]);

for b=1:B
    imb = im(:,:,b);
    [ im_stretched ] = im_hard_percentile_thresholding( imb,tol );
    im_stretched3D(:,:,b) = im_stretched;
end

if isempty(band_names)
    band_names = arrayfun(@(x) sprintf('band-%d',x),1:B,'UniformOutput',false);
end

if nargout==0
    cur_state = State_scx_3d();
    cur_state.current_band = band_default;
    fig = figure('KeyPressFcn',{@moveBand,im_stretched3D,cur_state,band_names});
    sc(im_stretched3D(:,:,cur_state.current_band));
    hdt = datacursormode(fig);
    set(hdt,'UpdateFcn',{@map_cursor_Orivalue,im(:,:,:),cur_state});
    fig.Name = band_names{cur_state.current_band};
end

% switch method
%     case 'linear'
%         im_showed3D = nan([L,S,3,B]);
%         for b=1:B
%             im_stretchedb = im_stretched3D(:,:,b);
%             [im_showed,crange] = im_lstretch(im_stretchedb,crange);
%             im_showed3D(:,:,:,b) = im_showed;
%         end
%     otherwise
%         error('input method is not supported');
% end

% switch method
%     case 'linear'
%         if nargout>1
%             % sc(im_showed,varargin{:});
%         else
%             sc(im_showed(:,:,band_default),varargin{:});
%         end
%     otherwise
%         error('input method is not supported');
% end
% 
% hdt = datacursormode(gcf);
% set(hdt,'UpdateFcn',{@map_cursor_Orivalue,im});


% axes(ax_ori);

end

function output_txt = map_cursor_Orivalue(obj,event_obj,CData,cur_state)
% Display the position of the data cursor
% obj          Currently not used (empty)
% event_obj    Handle to event object
% output_txt   Data cursor text string (string or cell array of strings).
b = cur_state.current_band;
pos = get(event_obj,'Position');
output_txt = {['X: ',num2str(pos(1),4)],...
    ['Y: ',num2str(pos(2),4)],['Val: ' num2str(CData(pos(2),pos(1),b))]};

% % If there is a Z-coordinate in the position, display it as well
% if length(pos) > 2
%     output_txt{end+1} = ['Z: ',num2str(pos(3),4)];
% end

end

function [] = moveBand(obj,event_obj,im3D,cur_state,band_names)
% Display the position of the data cursor
% obj          Currently not used (empty)
% event_obj    Handle to event object
% output_txt   Data cursor text string (string or cell array of strings).

% pos = get(event_obj,'Position');
% output_txt = {['X: ',num2str(pos(1),4)],...
%     ['Y: ',num2str(pos(2),4)],['Val: ' num2str(CData(pos(2),pos(1),:))]};
switch event_obj.Character
    case 'v'
        if cur_state.current_band < size(im3D,3)
            cur_state.current_band = cur_state.current_band+1;
        end
    case 'b'
        if cur_state.current_band>1
            cur_state.current_band = cur_state.current_band-1;
        end
end

switch event_obj.Character
    case {'v','b'}
        obj;
        xlim_cur = obj.CurrentAxes.XLim;
        ylim_cur = obj.CurrentAxes.YLim;
        obj.Name = band_names{cur_state.current_band};
        sc(im3D(:,:,cur_state.current_band));
        xlim(obj.CurrentAxes,xlim_cur);
        ylim(obj.CurrentAxes,ylim_cur);
end

% % If there is a Z-coordinate in the position, display it as well
% if length(pos) > 2
%     output_txt{end+1} = ['Z: ',num2str(pos(3),4)];
% end

end