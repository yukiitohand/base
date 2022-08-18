function [ str_r ] = rmdq( str,varargin )
% [ str_r ] = rmdq( str )
% [ str_r ] = rmdq( str,'both')
%   
%   Remove the double quotations on either or both of the ends
% mode_rmdq = 'either';
% if nargin>1
%     mode_rmdq = 'both';
% end


if ischar(str)
    str_r = regexp(str,'^["]{0,1}([^"]*)["]{0,1}$','once','tokens');
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

