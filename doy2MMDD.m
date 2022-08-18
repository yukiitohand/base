function [MM,dd] = doy2MMDD(doy,yyyy)
% [MM,dd] = doy2MMDD(doy,yyyy)
%  convert day of the year to month and day of months
%  Input
%   doy: day of the year, numeric or string
%   yyyy: year, numeric or string
%  Output
%   MM: month, numeric
%   dd: day of the month, numeric

if ~isnumeric(doy), doy = str2num(doy); end

[days_of_months] = get_days_of_months(yyyy);

dom_cum = cumsum(days_of_months);

MM = find((doy-dom_cum)<=0,1);

if MM>1
    dd = doy - dom_cum(MM-1);
else
    dd = doy;
end

end