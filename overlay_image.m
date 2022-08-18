function [image_overlaid] = overlay_image(image_base,image_top,varargin)
% value less than 1e-5 are not overlaid
% Input Parameters
%  image_base: [MxNxP] image at the bottom layer
%  image_top : [MxNxP] image to be overlaid
% Output Parameters
%  image_overlaid" [MxNxP] image overlaid
% Optional Parameters
%   'Overlay_Valid': [MxN] boolean image (true are overlaid)
%                          (default) [], then sum(image_top,3)>1e-5 are
%                          replaced.
%              
img_overlay_valid = [];

if (rem(length(varargin),2)==1)
    error('Optional parameters should always go by pairs');
else
    for i=1:2:(length(varargin)-1)
        switch upper(varargin{i})
            case 'OVERLAY_VALID'
                img_overlay_valid = varargin{i+1};
            otherwise
                % Hmmm, something wrong with the parameter string
                error(['Unrecognized option: ''' varargin{i} '''']);
        end
    end
end

if isempty(img_overlay_valid)
    img_overlay_valid = sum(image_top,3)>1e-5;
end

image_overlaid = image_base;

B = size(image_base,3);
for b=1:B
    imb = image_overlaid(:,:,b);
    imib = image_top(:,:,b);
    imb(img_overlay_valid) = imib(img_overlay_valid);
    image_overlaid(:,:,b) = imb;
end