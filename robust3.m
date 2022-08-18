function [ data_proc,outliers ] = robust3(func,data,dim,varargin )


if dim==2
    data = permute(data,[2,1,3]);
elseif dim==3
    data = permute(data,[3,2,1]);
end  
[L,S,B] = size(data);

outliers = false([L,S,B]);
data_proc = zeros([1,S,B]);
for b=1:B
    datatmp = data(:,:,b);
    datatmp = squeeze(datatmp);
    [ datastdtmp,outlierstmp ] = robust(func,datatmp,dim,varargin{:});
    data_proc(1,:,b) = datastdtmp;
    outliers(:,:,b) = outlierstmp;
end

if dim==2
    data_proc = permute(data_proc,[2,1,3]);
    outliers = permute(outliers,[2,1,3]);
elseif dim==3
    data_proc = permute(data_proc,[3,2,1]);
    outliers = permute(outliers,[3,2,1]);
end 

end