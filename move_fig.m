function [ flg ] = move_fig( fig,x,y )
% [ flg ] = move_fig( fig,x,y )
%   
pos = get(fig,'Position');
pos = [x y pos(3) pos(4)];
set(fig,'Position',pos);

end

