function alignedStruct = splitTrials(dataStruct)
%alignedStruct = splitTrials(dataStruct)
%
%the function accepts a struct as an argument. the struct results from
%separateTrials function, which contains x, y, event, signalIndex of individual
%trials
%
%the loop takes values from the struct containing individual trials, splits
%the y coordinate information into two vectors and initializes another
%struct to store each couple of vectors. it also keeps track of the largest
%element in both vectors. Also timePre and timePost fields are present.

alignedStruct(1:length(dataStruct)) = struct('Ypre',[],'Ypost', [],'YtimePre',[],'YtimePost', [],'preLength', 0 ,'postLength', 0);

for i = 1:length(dataStruct)
    
    alignedStruct(i).Ypre = double(dataStruct(i).y(1:dataStruct(i).signalIndex-1));
    alignedStruct(i).YtimePre = double(dataStruct(i).time(1:dataStruct(i).signalIndex-1));
    alignedStruct(i).Ypost =  double(dataStruct(i).y(dataStruct(i).signalIndex:end));
    alignedStruct(i).YtimePost =  double(dataStruct(i).time(dataStruct(i).signalIndex:end));
    alignedStruct(i).preLength = length(alignedStruct(i).Ypre);
    alignedStruct(i).postLength = length(alignedStruct(i).Ypost);
    
end