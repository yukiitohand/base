function [Mnan] = replace0withNaN(M)
Mnan = double(M);
Mnan(Mnan==0) = nan;
end