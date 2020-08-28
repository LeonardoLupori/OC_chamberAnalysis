clc, clearvars;

data = openTrackFile();
sepdata = separateTrials(data);
dataTrials = splitTrials(sepdata);

speedTrialsCell = speedTrials(dataTrials, dataTrials);

%two matrices to display frames before and after the stimulus appearance on
%the screen
preMatrix = nan(length(dataTrials),max([dataTrials.preLength]));
postMatrix = nan(length(dataTrials),max([dataTrials.postLength]));
for i = 1:length(dataTrials)
    vecLength = length(dataTrials(i).Ypre);
    preMatrix(i,end-vecLength+1:end) = speedTrialsCell{i,1};
    vecLength = length(dataTrials(i).Ypost);
    postMatrix(i,1:vecLength) = speedTrialsCell{i,2};
end
%image is obtained by the alignment of each trial. the line indicates the
%presence of the stimulus. The axes are appropriately labeled.
imagesc(cat(2,preMatrix,postMatrix))
colormap jet
ax = gca;
line([max([dataTrials.preLength])+1 max([dataTrials.preLength])+1],ax.YLim,'color','k','linewidth',1.4)
ax.XLabel.String = 'Tracking frame';
ax.YLabel.String = 'Trial #';





