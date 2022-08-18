function [ str_r ] = rmquotes( str )
% [ str_r ] = rmquotes( str ) 
%  Remove the single quotations on either or both of the ends


if ischar(str)
    str_r = regexp(str,'^['']{0,1}([^'']*)['']{0,1}$','once','tokens');
    if ~isempty(str_r)
        str_r = str_r{1};
    else
        str_r = str;
    end
else
    str_r = str;
end

% fprintf('%s,%s',str,str_r);

end