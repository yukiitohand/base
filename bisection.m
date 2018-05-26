function [x0,idx0] = bisection(x)
%[idx0] = bisection(x)
%   Assume monchromatic increasing of x, find the value and index closest to zero.
s_max = length(x);
s_min = 1;
s_med = floor((s_max+s_min)/2);

if x(s_min) >= 0
    idx0 = 1; x0 = x(1);
    % s_max = s_min; s_med = s_min;
else
    if x(s_max) <= 0
        idx0 = s_max; x0 = x(s_max);
        % s_min = s_max; s_med = s_max;
    else
        while(s_max-s_min>1)
            if x(s_med) <= 0
                s_min = s_med; s_med = ceil((s_max+s_min)/2);
            else
                s_max = s_med; s_med = floor((s_max+s_min)/2);
            end
        end
        if abs(x(s_min))<abs(x(s_max))
            idx0 = s_min; x0 = x(s_min);
        else
            idx0 = s_max; x0 = x(s_max);
        end
    end
end

end

