function [ im_stretched ] = im_lstretch( im )
%[ im_stretched ] = im_lstretch( im )
%   stretch the image channel by channel

im = squeeze(im);

if ismatrix(im)
    im_stretched = real2rgb( im, gray );
elseif size(im,3)==3
    [ r ] = real2rgb( im(:,:,1), gray );
    [ g ] = real2rgb( im(:,:,2), gray );
    [ b ] = real2rgb( im(:,:,3), gray );
    im_stretched = cat(3,r(:,:,1),g(:,:,1),b(:,:,1));
else
    error('The size of the input image is invalid');

end

