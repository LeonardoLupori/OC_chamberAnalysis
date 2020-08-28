function alignedStruct = splitTrials(dataStruct)
% alignedStruct = splitTrials(dataStruct, coordToTrack)
%
% the function accepts a struct as an argument. the struct results from
% separateTrials function, which contains x, y, event, signalIndex of individual
% trials
%
% the loop takes values from the struct containing individual trials, splits
% the y coordinate information into two vectors and initializes another
% struct to store each couple of vectors. it also keeps track of the largest
% element in both vectors. Also timePre and timePost fields are present.


% Initialize the struct
alignedStruct(1:length(dataStruct)) = struct(...
    'Xpre',[],...
    'Xpost', [],...
    'Ypre',[],...
    'Ypost', [],...
    'timePre',[],...
    'timePost', [],...
    'preLength', 0 ,...
    'postLength', 0);

for i = 1:length(dataStruct)
    % X Positions
    alignedStruct(i).Xpre = double(dataStruct(i).x(1:dataStruct(i).signalIndex-1));
    alignedStruct(i).Xpost =  double(dataStruct(i).x(dataStruct(i).signalIndex:end));
    % Y Positions
    alignedStruct(i).Ypre = double(dataStruct(i).y(1:dataStruct(i).signalIndex-1));
    alignedStruct(i).Ypost =  double(dataStruct(i).y(dataStruct(i).signalIndex:end));
    % Time 
    alignedStruct(i).timePre = double(dataStruct(i).time(1:dataStruct(i).signalIndex-1));
    alignedStruct(i).timePost =  double(dataStruct(i).time(dataStruct(i).signalIndex:end));
    % Length
    alignedStruct(i).preLength = length(alignedStruct(i).Ypre);
    alignedStruct(i).postLength = length(alignedStruct(i).Ypost);
end