function [ dirs,files ] = list_dir( dirpath,varargin )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
basenamePtrn = '.*';

if (rem(length(varargin),2)==1)
    error('Optional parameters should always go by pairs');
else
    for i=1:2:(length(varargin)-1)
        switch upper(varargin{i})
            case 'BASENAMEPTRN'
                basenamePtrn = varargin{i+1};
            otherwise
                % Hmmm, something wrong with the parameter string
                error(['Unrecognized option: ''' varargin{i} '''']);
        end;
    end;
end

if ~strcmp(dirpath(end),'/')
    dirpath = [dirpath '/'];
end

if ~exist(dirpath,'dir')
    error('"%s" does not exist.',dirpath);
end


listing = dir(dirpath);
dirs = [];
files = [];
match_flg = 0;
for i=1:length(listing)
    name = listing(i).name;
    if ~isempty(regexp(name,basenamePtrn,'ONCE'))
        fprintf('%s\n',name);
        match_flg = 1;
        if listing(i).isdir
           dirs = [dirs {name}];
        else
           if exist([dirpath name],'file')
               files = [files {name}];
           end
        end
        
    end
end

if match_flg==0
    fprintf('No file matches %s in %s.\n',basenamePtrn,dirpath);
end


end

