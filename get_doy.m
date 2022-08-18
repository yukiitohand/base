function [doy] = get_doy(yyyy)
% [doy] = get_doy(yyyy)
%   caculate the number of days in 'yyyy'
%   Input Parameters
%      yyyy: year to be tested, string or numeric
%   Outputs
%      doy: number of the doys in the year specified.
if isleapyear(yyyy)
    doy=366;
else
    doy=365;
end

end