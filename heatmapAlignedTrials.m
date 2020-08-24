clc, clearvars;
data = openTrackFile();

TrialStruct  = separateTrials(data);
YdataTrials = splitTrials(TrialStruct);

%two matrices to display frames before and after the stimulus appearance on
%the screen
preMatrix = nan(length(YdataTrials),max([YdataTrials.preLength]));
postMatrix = nan(length(YdataTrials),max([YdataTrials.postLength]));
for i = 1:length(YdataTrials)
    vecLength = length(YdataTrials(i).Ypre);
    preMatrix(i,end-vecLength+1:end) = YdataTrials(i).Ypre;
    vecLength = length(YdataTrials(i).Ypost);
    postMatrix(i,1:vecLength) = YdataTrials(i).Ypost;
end
%image is obtained by the alignment of each trial. the line indicates the
%presence of the stimulus. The axes are appropriately labeled.
imagesc(cat(2,preMatrix,postMatrix))
colormap jet
ax = gca;
line([max([YdataTrials.preLength])+1 max([YdataTrials.preLength])+1],ax.YLim,'color','k','linewidth',1.4)
ax.XLabel.String = 'Tracking frame';
ax.YLabel.String = 'Trial #';




