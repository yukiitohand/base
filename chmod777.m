function [status,msg] = chmod777(fpath,verbose)
% [status,msg] = chmod777(fpath,verbose)
%  Change the permission of the file to 777. Only works with Unix machine. 
%  INPUTS
%   fpath: path to the file or directory
%   verbose: Print the result or not.
%  OUTPUTS
%   status: same as the output of fileattrib
%   msg   : same as the output of fileattrib

[status,msg] = fileattrib(fpath, '+w +x','a');
if status
    if verbose
        fprintf('"%s": permission is set to 777.\n',fpath);
    end
else
    % error([fpath ':' msg]);
end

end

% Following is the more raw command. Problem is that you do not know the
% chmod succeeded or not.
%
% if isunix
%     system(['chmod 777 ' fpath]);
%     if verbose, fprintf('"%s": permission is set to 777.\n',fpath); end
% end
% 