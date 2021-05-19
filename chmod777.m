function [] = chmod777(fpath,verbose)
% [] = chmod777(fpath,verbose)
%  Change the permission of the file to 777. Only works with Unix machine. 
%  INPUTS
%   fpath: path to the file or directory
%   verbose: Print the result or not.

[status,msg] = fileattrib(fpath, '+w +x','a');
if status
    if verbose
        fprintf('"%s": permission is set to 777.\n',fpath);
    end
else
    error([fpath ':' msg]);
end

end