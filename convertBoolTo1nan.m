function [x1nan] = convertBoolTo1nan(x)
% [x1nan] = convertBoolTo1nan(x)
%  convert binary array to 1-nan format ( falses (0) will be replaced with
%  NaNs).
%  INPUT
%   x: binary array
%  OUTPUT
%   x1nan: double precision array, where falses are replaced with nans

% check the input array is binary.
validateattributes(x,{'logical','numeric'},{'binary'});

x1nan = double(x);
x1nan(x==0) = nan;

end