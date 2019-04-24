function [doy] = MMDDYYYY2doy(month,dd,yyyy)
% [doy] = MMDDYYYY2doy(month,dd,yyyy)
%  convert the date information (month,dd,yyyy) to day of the year (doy).
%  Input
%    month: can be numeric of string ('Jan' is also accepted)
%    dd: day of the month, numeric or string
%    yyyy: year, numeric or string
%  Output
%    doy: day of the year
% 
[month_num] = get_month_num(month);

if ~isnumeric(dd), dd = str2num(dd); end

[days_of_months] = get_days_of_months(yyyy);

doy = sum(days_of_months(1:(month_num-1))) + dd;

end
           