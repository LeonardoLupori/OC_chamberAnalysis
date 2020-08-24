function dataStruct = separateTrials(data)
%dataStruct = separateTrials(data)
%
%the function accepts a struct as an argument. The struct contains 'rect',
%'x','y','event' fields. the function returns a monodimensional struct with
%fields 'x','y','event','signalIndex', 'time' fields for each trial, the first and
%the last trial are omitted. trials begin with button press
%
%see also: event2vector, openTrackFiles

e = event2vector(data.event);
evBin = e>0;
%the following vector contains +1 for the first frame where the signal appears
%(both condition), -1 for the end of the trial (botton pressed)
eTimePoint = [0, diff(evBin)];
buttonpIndexVector = find(eTimePoint == -1);
%preallocate a cell to store individual trials,


for i = 1:(length(buttonpIndexVector)-2)
    dataStruct(i).x = data.x(buttonpIndexVector(1,i):(buttonpIndexVector(1,i+1)-1));
    dataStruct(i).y = data.y(buttonpIndexVector(1,i):(buttonpIndexVector(1,i++1)-1));
    dataStruct(i).event = evBin(buttonpIndexVector(1,i):(buttonpIndexVector(i+1)-1));
    dataStruct(i).signalIndex = find(dataStruct(i).event,1,'first');
    dataStruct(i).time = data.time(buttonpIndexVector(1,i):(buttonpIndexVector(1,i+1)-1));
end

end