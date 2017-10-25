function str = cell1dstrprintf(cellar,delimiter,bracket)

[L,C] = size(cellar);
u = [delimiter, '%s'];

if L==1
    fprintfar = [bracket(1) '%s' repmat(u, [1, C-1]) bracket(2)];
    str = sprintf(fprintfar,cellar{1,:});
end

end

    
        
    