function eventVector = event2vector(eventCell)
% eventVector = event2vector(eventCell)
% the function takes the elements from the event cell (n,1) and returns a
% vertical vector(1,n), codifying the event strings as numbers. if the
% string does not match with the events listed below, it is codified as NaN

% 0 = 0
% both = 1
% left = 2
% right = 3

eventVector = zeros(1,length(eventCell));
for i = 1:length(eventVector)
    if strcmp(eventCell(i),'0') == 1
        eventVector(1,i) = 0;
    elseif strcmp(eventCell(i),'both') == 1
        eventVector(1,i) = 1;
    elseif strcmp(eventCell(i),'left') == 1
        eventVector(1,i) = 2;
    elseif strcmp(eventCell(i),'right') == 1
        eventVector(1,i) = 3;
    else
        eventVector(1,i) = NaN;
    end
end



