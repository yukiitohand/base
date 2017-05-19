function [ filepath_new ] = findfilei( fname,pathstr )
% [ filepath_new ] = findfilei( filepath )
%   find file in a case insensitive way
%   Inputs
%     fname: queried name of the file (case insensitive)
%     pathstr: dirpath
%   Outputs
%     filepath_new: real path to the file

if ~exist(pathstr,'dir')
    error('%s does not exist',pathstr);
end

lsList = dir(pathstr);

[res,resIdx] = searchby('name',fname,lsList,'COMP_FUNC','strcmpi');

filepath_new = [{res.name}];

end

