clearvars, clc, close all
%open and process data
data = openTrackFile();
TrialStruct  = separateTrials(data);
YdataTrials = splitTrials(TrialStruct);
threshold = (data.rect(2)+data.rect(4))/2 ;
filterSize = 21;


YposMatrix = zeros(length(YdataTrials), max([YdataTrials.preLength]));
for i = 1:length(YdataTrials)
    
    YposMatrix(i,1:YdataTrials(i).preLength) = smooth(YdataTrials(i).Ypre, filterSize);  
    
end
a = YposMatrix>threshold;
Y = diff(a,1,2);
sum(Y, 2);