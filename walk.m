function [Files_struct] = walk(rootDir)
verbose = false;
ignorant_list = {'^\.$','^\.\.$','^\.DS_Store$'};


Files_struct = [];
if verbose
    fprintf('Entering %s\n',rootDir);
end
children = dir(rootDir);
for i = 1:length(children)
    child_name = children(i).name;
    if all(cellfun(@(x) isempty(x), regexpi(child_name,ignorant_list,'Once')))
        if children(i).isdir
            idx_end = length(Files_struct); 
            Files_struct(idx_end+1).name = child_name;
            Files_struct(idx_end+1).folder = children(i).folder;
            Files_struct(idx_end+1).path = joinPath(children(i).folder,child_name);
            Files_struct(idx_end+1).isdir = 1;
            child_dir = joinPath(children(i).folder,child_name);
            [Files_struct_i] = walk(child_dir);
            Files_struct = merge_struct(Files_struct,Files_struct_i);
        else
            idx_end = length(Files_struct); 
            Files_struct(idx_end+1).name = child_name;
            Files_struct(idx_end+1).folder = children(i).folder;
            Files_struct(idx_end+1).path = joinPath(children(i).folder,child_name);
            Files_struct(idx_end+1).isdir = 0;
        end
    end
end