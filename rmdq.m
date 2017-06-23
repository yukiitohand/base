function [ str_r ] = rmdq( str,varargin )
% [ str_r ] = rmdq( str )
% [ str_r ] = rmdq( str,'both')
%   
%   Remove the double quotations on either or both of the ends
mode = 'either';
if nargin>1
    mode = 'both';
end


if ischar(str)
    if ~isempty(regexp(str,'^"([^"]*)"$','ONCE'))
        str_r = regexp(str,'^"([^"]*)"$','tokens');
        str_r = str_r{1}{1};
    elseif strcmpi(mode,'either')
        if ~isempty(regexp(str,'^"([^"]*)$','ONCE'))
            str_r = regexp(str,'^"([^"]*)$','tokens');
            str_r = str_r{1}{1};
        elseif ~isempty(regexp(str,'^([^"]*)"$','ONCE'))
            str_r = regexp(str,'^([^"]*)"$','tokens');
            str_r = str_r{1}{1};
        else
            str_r = str;
        end
    else
        str_r = str;
    end
else
    str_r = str;
end

end

