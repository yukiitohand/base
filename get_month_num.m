function [month_num] = get_month_num(month)
% [month_num] = get_month_num(month)
%  get the digit expression of month
%   Input
%    month: str or numeric, e.g. '01','1','Jan',1
%   Output
%    month_num: numeric expression of month, 1--12
%  Note
%   if the input is numeric, then the numeric value is just returned.


if isnumeric(month)
    month_num = month;
elseif ischar(month)
    month_tmp = str2num(month);
    if ~isempty(month_tmp)
        month_num = month_tmp;
    else
        months_strcell = {'Jan.*','Feb.*','Mar.*','Apr.*','May.*','Jun.*'...
            'Jul.*','Aug.*','Sep.*','Oct.*','Nov.*','Dec.*'};
        month_num = find(~isempties(regexpi(month,months_strcell)));
    end
end

end