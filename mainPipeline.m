clearvars, clc

workingPath = 'C:\Users\Leonardo\Documents\MATLAB\OC_chamberAnalysis';
addpath(genpath(workingPath))

%%
data = openTrackFile();
dataStruct = separateTrials(data);
alignedStruct = splitTrials(dataStruct);

%%
[nX, nY] = normalizeCoord(data.x, data.y, data.rect);
% plot(data.x,data.y)
plot(nX,nY)
