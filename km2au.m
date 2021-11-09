function [ d_au ] = km2au( d_km )
% [ d_au ] = km2au( d_km )
%   convert km to astronomical unit

c = 149597870700 ./1000;
c =1.496e8;
d_au = d_km./c;

end

