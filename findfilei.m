function [ fnamei ] = findfilei( fname,pathstr )
% [ fnamei ] = findfilei( filepath )
%   find file in a case insensitive way
%   Inputs
%     fname: queried name of the file (case insensitive)
%     pathstr: dirpath
%   Outputs
%     fnamei: real file name, if only one, string, if multiple, cell arrays

if ~exist(pathstr,'dir')
    error('%s does not exist',pathstr);
end

lsList = dir(pathstr);

[res,resIdx] = searchby('name',fname,lsList,'COMP_FUNC','strcmpi');

fnamei = [{res.name}];

if length(fnamei)==1
    fnamei = fnamei{1};
end

end

