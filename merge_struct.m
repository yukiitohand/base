function [ struct_new ] = merge_struct( varargin )
%[ struct_concatenated ] = merge_struct( varargin )
%   Expand struct having different fields
%  Usage
%    [ struct_new ] = expand_struct( struct1,struct2,struct3,... )
%    empty struct can be an input.

switch length(varargin)
    case 0
        error('Empty input');
    case 1
        error('No need to concatenate');
    otherwise
end

structList = varargin;

if all(cellfun(@(x) isempty(x), structList))
    struct_new = [];
else
    allfieldnames = {};
    L = 0;
    for i=1:length(structList)
        struct_cur = structList{i};
        if ~isempty(struct_cur)
            allfields_cur = fieldnames(struct_cur);
            allfieldnames = union(allfieldnames,allfields_cur);
            L = L + length(struct_cur);
        end
    end

    struct_new = struct(allfieldnames{1},cell(1,L));
    for i=1:length(allfieldnames)
        [struct_new.(allfieldnames{i})] = deal([]);
    end

    cumj = 0;
    for i=1:length(structList)
        struct_cur = structList{i};
        if ~isempty(struct_cur)
            s = length(struct_cur);
            allfields_cur = fieldnames(struct_cur);
            for j=1:length(allfields_cur)
                fld = allfields_cur{j};
                for k=1:s
                    struct_new(k+cumj).(fld) = struct_cur(k).(fld);
                end
                % initialize the other using automatic estimation of the data type
                % of each field.
                setc = setdiff(1:L,cumj+1:cumj+s); 
                idx_isempty = cellfun(@(x) isempty(x), [{struct_new(setc).(fld)}]);
                repr = struct_new(cumj+1).(allfields_cur{j});
                if isstr(repr)
                    [struct_new(setc(idx_isempty)).(fld)] = deal('');
                elseif isscalar(repr)
                    [struct_new(setc(idx_isempty)).(fld)] = deal(NaN);
                end

            end
            cumj = cumj + s;
        end
    end
    
end

end

