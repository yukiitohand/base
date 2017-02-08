function [ flag ] = set_figsize( fig,width,height )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
unit = get(fig,'Units');
screenSize = get(0,'ScreenSize');
sw = screenSize(3); sh = screenSize(4);
if strcmp(unit,'pixels')
    if height > sh
        height = sh-130;
    end
    if width > sw
        width = sw-16;
    end
    set(fig,'Position',[(sw-width)/2,sh-82-height,width,height]);
else
    set(fig,'Position',[0,0,width,height]);
    set(fig,'Units','pixels');
    pos = get(fig,'Position');
    set(fig,'Position',[(sw-pos(3))/2,sh-82-pos(4),pos(3),pos(4)]);
    set(fig,'Units',unit);

end

