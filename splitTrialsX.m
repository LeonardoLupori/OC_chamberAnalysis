function alignedStruct = splitTrialsX(dataStruct)
%alignedStruct = splitTrialsX(dataStruct)
%
%the function accepts a struct as an argument. the struct results from
%separateTrials function, which contains x, y, event, signalIndex of individual
%trials
%
%the loop takes values from the struct containing individual trials, splits
%the x coordinate information into two vectors and initializes another
%struct to store each couple of vectors. it also keeps track of the largest
%element in both vectors. Also timePre and timePost fields are present.

alignedStruct(1:length(dataStruct)) = struct('Xpre',[],'Xpost', [],'XtimePre',[],'XtimePost', [],'preLength', 0 ,'postLength', 0);

for i = 1:length(dataStruct)
    
    alignedStruct(i).Xpre = double(dataStruct(i).x(1:dataStruct(i).signalIndex-1));
    alignedStruct(i).XtimePre = double(dataStruct(i).time(1:dataStruct(i).signalIndex-1));
    alignedStruct(i).Xpost =  double(dataStruct(i).x(dataStruct(i).signalIndex:end));
    alignedStruct(i).XtimePost =  double(dataStruct(i).time(dataStruct(i).signalIndex:end));
    alignedStruct(i).preLength = length(alignedStruct(i).Xpre);
    alignedStruct(i).postLength = length(alignedStruct(i).Xpost);
    
end