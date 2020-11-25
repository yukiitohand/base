function [flg_cont] = doyouwantto(doverb,prompt1)
% [flg_cont] = doyouwantto(prompt1)
%   ask if you want to <doverb> and return boolean
% INPUTS
%  doverb: character strings, do you want to <doverb>
%  prompt1: character strings, first line of the question.
% OUTPUTS
%  flg_cont: boolean, true if you return yes, false otherwise.
flg_ask = 1;
while flg_ask
    prompt1 = sprintf('%s.\n Do you want to %s?(y/n)',prompt1,doverb);
    ow = input(prompt1,'s');
    if any(strcmpi(ow,{'y','n'}))
        flg_ask=0;
    else
        fprintf('Input %s is not valid.\n',ow);
    end
end
switch ow
    case 'y'
        flg_cont = true;
    case 'n'
        flg_cont = false;
end

end