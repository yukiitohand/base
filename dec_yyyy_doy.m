function [yyyy,doy] = dec_yyyy_doy(yyyy_doy)
% [yyyy,doy] = dec_yyyy_doy(yyyy_doy)
%  decompose yyyy_doy to yyyy, doy
%  Input
%   yyyy_doy: string
%  Output
%   yyyy: year, numeric
%   doy: doy of the year, numeric
    y = sscanf(yyyy_doy,'%d_%d');
    doy = y(2);
    yyyy = y(1);
end