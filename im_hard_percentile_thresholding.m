function [ im_stretched,lowhigh,is_extrm_mask ] = im_hard_percentile_thresholding( im,tol )
% [ im_stretched ] = im_hard_percentile_thresholding( im,tol )
%   round lowest and highest (tol)*100 [%] values in its percentile channel
%   by channel
%   Inputs
%     im: image [M x N x 1] or [M x N x 3]
%     tol: scalar or 1 x 2 array.
%   Outputs
%     im_stretched: same size 
%     lowhigh: [1 x 2] or [3 x 2], each row shows the minimum and maximum
%     value in the stretched image.
%     is_extrm_mask: [M x N x 1] or [M x N x 3], boolean, true if an image
%     cell has an extreme value, false otherwise.

im = squeeze(im);

if ismatrix(im)
    [im_stretched,lowhigh,is_extrm_mask] = hard_percentile_thresholding( im,tol );
elseif size(im,3)==3
    [ r,lowhigh_r,is_extrm_mask_r ] = hard_percentile_thresholding( im(:,:,1),tol );
    [ g,lowhigh_g,is_extrm_mask_g ] = hard_percentile_thresholding( im(:,:,2),tol );
    [ b,lowhigh_b,is_extrm_mask_b ] = hard_percentile_thresholding( im(:,:,3),tol );
    im_stretched = cat(3,r,g,b);
    lowhigh = [lowhigh_r;lowhigh_g;lowhigh_b];
    is_extrm_mask = cat(3,is_extrm_mask_r,is_extrm_mask_g,is_extrm_mask_b);
else
    error('The size of the input image is invalid');
end


end

