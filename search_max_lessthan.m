function [v,i] = search_max_lessthan(val,ar)
% [v,i] = search_max_lessthan(val,ar)
%  search the maximum value among the items less than 'val' in the array
%  'ar'

ss = ar-val;

idx_sub = find(ss<0);

[max_idx_sub,max_idx_sub_i] = max(ss(idx_sub));

i = idx_sub(max_idx_sub==ss(idx_sub));
v = ar(i);

end