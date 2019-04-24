function [days_of_months] = get_days_of_months(yyyy)
% [days_of_months] = get_days_of_months(yyyy)
%  Input
%   yyyy: year, num or str
%  Output
%   days_of_months: (12,1) array, the ith element of which stores the 
%                   number of days of the month i.


days_of_months = zeros(12,1);
days_of_months(1) = 31;
if isleapyear(yyyy)
    days_of_months(2) = 29;
else
    days_of_months(2) = 28;
end
days_of_months(3) = 31;
days_of_months(4) = 30;
days_of_months(5) = 31;
days_of_months(6) = 30;
days_of_months(7) = 31;
days_of_months(8) = 31;
days_of_months(9) = 30;
days_of_months(10) = 31;
days_of_months(11) = 30;
days_of_months(12) = 31;



end