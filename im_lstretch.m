function [ im_stretched,crange ] = im_lstretch( im,crange )
%[ im_stretched,crange ] = im_lstretch( im )
%   stretch the image channel by channel
%   Inputs
%      im: image [M x N x 1] or [M x N x 3]
%      crange: color range [1 x 2] or [3 x 2]
%              each of the row contains [minv, maxv] for the channel
%   Outputs
%      im_stretched: coverted image
%      crange: color range [1 x 2] or [3 x 2]
%              each of the row contains [minv, maxv] for the channel

im = squeeze(im);

if ismatrix(im)
    [ im_stretched,crange ] = im_lstretch_base( im,crange );
elseif size(im,3)==3
    if isempty(crange)
        [ r,cranger ] = im_lstretch_base( im(:,:,1), []);
        [ g,crangeg ] = im_lstretch_base( im(:,:,2), []);
        [ b,crangeb ] = im_lstretch_base( im(:,:,3), []);
    else
        [ r,cranger ] = im_lstretch_base( im(:,:,1), crange(1,:) );
        [ g,crangeg ] = im_lstretch_base( im(:,:,2), crange(2,:) );
        [ b,crangeb ] = im_lstretch_base( im(:,:,3), crange(3,:) );
    end
    
    crange = cat(1,cranger,crangeg,crangeb);
    im_stretched = cat(3,r(:,:,1),g(:,:,1),b(:,:,1));
else
    error('The size of the input image is invalid');

end

end

function [ im_stretched,crange ] = im_lstretch_base( im,crange )
    if isempty(crange)
        im_stretched = real2rgb( im, gray );
        minv = min2d(im);
        maxv = max2d(im);
        crange = [minv maxv];
    else
        if all(isnan(im(:)))
            im_stretched = zeros([size(im,2),size(im,1),3]);
        else
            im_stretched = real2rgb( im, gray, crange);
        end
    end
end

