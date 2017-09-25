function [struc] = addField(struc,field,value)
% add one value for field. If exist, additional value is added and the
% value for the field becomes cell type.
    if ~isempty(field)
        if isfield(struc,field)
            struc.(field) = [struc.(field) {value}];
        else
            struc.(field) = value;
        end
    else
        warning('field name %s is not valid',field);
    end
end