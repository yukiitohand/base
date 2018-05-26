function [ d_au ] = km2au( d_km )
% [ d_au ] = km2au( d_km )
%   convert km to astronomical unit

c = 149597870700 ./1000;
d_au = d_km./c;

end

