function [im_out] = imavefil_omitnan_dwnsmpl(im,fltsz)
% [im_out] = imavefil_omitnan_dwnsmpl(im,fltsz)
% Downsample the input image by applying an average filter on discrete image 
% blocks of size fltsz(1)-by-filtsz(2). NaN values are omitted. No padding 
% is performed and the remainder rows and columns will be discarded if exist.
%
% INPUTS
%   im: image [LxSxB]
%   fltsz: [1x2], the size of blocks in the 1st and 2nd dimensions.
% OUTPUTS
%   im_out: [LavexSavexB], 
%     where Lave = floor(L/fltsz(1)) and Save = floor(S/fltsz(2)).
%

[L,S,B] = size(im);
Lave = floor(L/fltsz(1)); Save = floor(S/fltsz(2));

im_crop = im(1:Lave*fltsz(1),1:Save*fltsz(2),:);

im_crop = reshape(im_crop,[Lave*fltsz(1),Save*fltsz(2)*B]);

im_col = im2col(im_crop,fltsz,'distinct');
im_col_ave = mean(im_col,1,'omitnan');
im_out = reshape(im_col_ave,Lave,Save,B);

% im_out = nan(Lave,Save,B);
% for b=1:B
%     imb = im_crop(:,:,b);
%     imb_col = im2col(imb,fltsz,'distinct');
%     imb_col_ave = mean(imb_col,1,'omitnan');
%     imb_ave = reshape(imb_col_ave,Lave,Save);
%     im_out(:,:,b) = imb_ave;
% end

end