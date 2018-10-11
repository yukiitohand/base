function [im_fltd] = nanimfilter(im,filt,varargin)
% [im_fltd] = nanimfilter(im,filt)
%   filter image considering nans. 

w = 1;

if (rem(length(varargin),2)==1)
    error('Optional parameters should always go by pairs');
else
    for i=1:2:(length(varargin)-1)
        switch upper(varargin{i})
            case 'WEIGHT'
                w = varargin{i+1};
            otherwise
                % Hmmm, something wrong with the parameter string
                error(['Unrecognized option: ''' varargin{i} '''']);
        end
    end
end

[L,S] = size(im);
if isscalar(w)
    w = w.*ones(L,S);
end

[l_size,s_size] = size(filt);

if isscalar(w)
    w = w.*ones(L,S);
end

if mod(l_size,2)~=1 || mod(s_size,2)~=1
    error('filter size is an even number.');
end
lh = (l_size-1)/2; sh = (s_size-1)/2;

im_pd = padarray(im,[lh,sh],NaN);
w_pd = padarray(w,[lh,sh],NaN);

im_pd_isgood = im_pd;
im_pd_isgood(~isnan(im_pd)) = 1;

im_isgood = im;
im_isgood(~isnan(im)) = 1;

im_concat = nan(L,S,l_size*s_size);
cff_concat = nan(L,S,l_size*s_size);

ii = 0;
for l = 1:l_size
    for s = 1:s_size
        ii = ii + 1;
        im_pd_isgood_tmp = im_pd_isgood(l:(l+L-1),s:(s+S-1)) .* w_pd(l:(l+L-1),s:(s+S-1));
        cff_concat(:,:,ii) = im_pd_isgood_tmp*filt(l,s);
        im_concat(:,:,ii) = im_pd(l:(l+L-1),s:(s+S-1)).* cff_concat(:,:,ii);
        % cff_concat(:,:,ii) = im_pd_isgood(l:(l+L-1),s:(s+S-1))*filt(l,s);
        % im_concat(:,:,ii) = im_pd(l:(l+L-1),s:(s+S-1)) .* cff_concat(:,:,ii);
    end
end

cff_sum = nansum(cff_concat,3);
im_fltd = nansum(im_concat,3) ./ cff_sum;

im_fltd = im_fltd .* im_isgood;

end






