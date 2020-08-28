function dataStruct = separateTrials(data)
% dataStruct = separateTrials(data)
%
% the function accepts a struct as an argument. The struct contains 'rect',
% 'x','y','event' fields. the function returns a monodimensional struct with
% fields 'x','y','event','signalIndex', 'time' fields for each trial, the first and
% the last trial are omitted. trials begin with button press
%
% see also: event2vector, openTrackFiles

e = event2vector(data.event);
evBin = e>0;

% the following vector contains +1 for the first frame where the signal appears
% (both condition), -1 for the end of the trial (button pressed)
eTimePoint = [0, diff(evBin)];
idxEnd = find(eTimePoint == -1);

% Compute the number of trials
totTrials = length(idxEnd);
totTrials = totTrials - 1;
% The total number of trials equals to the number of button presses -1 
%      trial       trial         trial
% --|---------|---------------|--------|----

% Put the data in an output struct
for i = 1:totTrials
    dataStruct(i).x = data.x(idxEnd(i):(idxEnd(i+1)-1));
    dataStruct(i).y = data.y(idxEnd(i):(idxEnd(i+1)-1));
    dataStruct(i).event = evBin(idxEnd(i):(idxEnd(i+1)-1));
    dataStruct(i).signalIndex = find(dataStruct(i).event,1,'first');
    dataStruct(i).time = data.time(idxEnd(i):(idxEnd(i+1)-1));
end
