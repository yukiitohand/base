function [im_out] = immedfil_omitnan_dwnsmpl(im,fltsz)
% [im_out] = immedfil_omitnan_dwnsmpl(im,fltsz)
% Downsample the input image by applying a median filter on discrete image 
% blocks of size fltsz(1)-by-filtsz(2). NaN values are omitted. No padding 
% is performed and the remainder rows and columns will be discarded if exist.
%
% INPUTS
%   im: image [LxSxB]
%   fltsz: [1x2], the size of blocks in the 1st and 2nd dimensions.
% OUTPUTS
%   im_out: [LmedxSmedxB], 
%     where Lmed = floor(L/fltsz(1)) and Smed = floor(S/fltsz(2)).
%

[L,S,B] = size(im);
Lmed = floor(L/fltsz(1)); Smed = floor(S/fltsz(2));

im_crop = im(1:Lmed*fltsz(1),1:Smed*fltsz(2),:);
im_crop = reshape(im_crop,[Lmed*fltsz(1),Smed*fltsz(2)*B]);

im_col = im2col(im_crop,fltsz,'distinct');
im_col_med = median(im_col,1,'omitnan');
im_out = reshape(im_col_med,Lmed,Smed,B);


end
