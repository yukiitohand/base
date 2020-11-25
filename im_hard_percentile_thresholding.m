function [ im_stretched,lowhigh ] = im_hard_percentile_thresholding( im,tol )
% [ im_stretched ] = im_hard_percentile_thresholding( im,tol )
%   round lowest and highest (tol)*100 [%] values in its percentile channel
%   by channel
%   Inputs
%     im: image [M x N x 1] or [M x N x 3]
%     tol:
%   Outputs
%     im_stretched: same size 

im = squeeze(im);

if ismatrix(im)
    [im_stretched,lowhigh] = hard_percentile_thresholding( im,tol );
elseif size(im,3)==3
    [ r,lowhigh_r ] = hard_percentile_thresholding( im(:,:,1),tol );
    [ g,lowhigh_g ] = hard_percentile_thresholding( im(:,:,2),tol );
    [ b,lowhigh_b ] = hard_percentile_thresholding( im(:,:,3),tol );
    im_stretched = cat(3,r,g,b);
    lowhigh = [lowhigh_r;lowhigh_g;lowhigh_b];
else
    error('The size of the input image is invalid');
end


end

