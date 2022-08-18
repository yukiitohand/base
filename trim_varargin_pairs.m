function [out_cellar] = trim_varargin_pairs(input_cellar,keys)
% [out_cellar] = trim_varargin_pairs(input_cellar,keys)
%  Trim the varargin with pairs
% INPUTS
%  input_cellar: cell array, paired varargin
%  keys: selected keys, cell or string
% OUTPUTS
%  out_cellar: cell array, trimed paired varargin

out_cellar_idxes = [];
if (rem(length(input_cellar),2)==1)
    error('Optional parameters should always go by pairs');
else
    for i=1:2:(length(input_cellar)-1)
        switch upper(input_cellar{i})
            case keys
                out_cellar_idxes = [out_cellar_idxes i i+1];
        end
    end
end

out_cellar = input_cellar(out_cellar_idxes);

end