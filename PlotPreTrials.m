%% Plot trials in their original length
%no standard length applied.

clearvars, clc, close all
%open and process data
data = openTrackFile();
TrialStruct  = separateTrials(data);
YdataTrials = splitTrials(TrialStruct);
threshold = (data.rect(2)+data.rect(4))/2 ;
%plot first trial
ax = axes;
plot(YdataTrials(1).Ypre);
hold on
% Y = diff(X,n,dim)
for i = 2:length(YdataTrials)
    
    plot(YdataTrials(i).Ypre);
end

line(ax.XLim,[threshold threshold])
hold off