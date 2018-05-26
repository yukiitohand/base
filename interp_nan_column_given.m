function [X] = interp_nan_column_given(X,Xisnan,Xinterp)
% interpolate cells in the matrix X flagged true in Xisnan with the values
% in Xinterp
% X and Xinterp must have the same shape.

X(Xisnan) = Xinterp(Xisnan);

% for l=1:size(X,2)
%     if any(Xisnan(:,l))
%         X(Xisnan(:,l),l) = Xinterp(Xisnan(:,l),l);
%     end
% end