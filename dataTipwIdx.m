function output_txt = dataTip(obj,event_obj,tempList,idList)
% Display the position of the data cursor
% obj          Currently not used (empty)
% event_obj    Handle to event object
% output_txt   Data cursor text string (string or cell array of strings).

pos = get(event_obj,'Position');
output_txt = {['X: ',num2str(pos(1),10)],...
    ['Y: ',num2str(pos(2),10)]};

% If there is a Z-coordinate in the position, display it as well
if length(pos) > 2
    output_txt{end+1} = ['Z: ',num2str(pos(3),4)];
end

% add idx
idx = get(event_obj,'DataIndex');
output_txt = [output_txt {['Index: ', num2str(idx)]}];
output_txt = [output_txt {['Temp: ', num2str(tempList(idx))]}];
output_txt = [output_txt {[': ', idList{idx}]}];

end