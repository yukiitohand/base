function [ isly ] = isleapyear( yyyy )
% [ dcsn ] = isleapyear( yyyy )
%   check 'yyyy' is a leap year
%   Input Parameters
%      yyyy: year to be tested, string or numeric
%   Outputs
%      isly: boolean, if yyyy is a leap year or not

if ischar(yyyy)
    yyyy = str2num(yyyy);
end

if mod(yyyy,4) ~=0
    isly = 0;
elseif mod(yyyy,100)~=0
    isly = 1;
elseif mod(yyyy,400)~=0
    isly=0;
else
    isly=1;
end

end

