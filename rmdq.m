function [ str_r ] = rmdq( str )
% [ str_r ] = rmdq( str )
%   Remove the double quotations on both of the ends
if ischar(str)
    if ~isempty(regexp(str,'^".*"$','ONCE'))
        str_r = str(2:end-1);
    else
        str_r = str;
    end
else
    str_r = str;
end

end

