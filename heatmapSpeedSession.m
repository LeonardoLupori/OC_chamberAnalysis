clc, clearvars;

data = openTrackFile();
sepdata = separateTrials(data);
YdataTrials = splitTrials(sepdata);
XdataTrials = splitTrialsX(sepdata);

speedTrialsCell = speedTrials(XdataTrials, YdataTrials);

%two matrices to display frames before and after the stimulus appearance on
%the screen
preMatrix = nan(length(YdataTrials),max([YdataTrials.preLength]));
postMatrix = nan(length(YdataTrials),max([YdataTrials.postLength]));
for i = 1:length(YdataTrials)
    vecLength = length(YdataTrials(i).Ypre);
    preMatrix(i,end-vecLength+1:end) = speedTrialsCell{i,1};
    vecLength = length(YdataTrials(i).Ypost);
    postMatrix(i,1:vecLength) = speedTrialsCell{i,2};
end
%image is obtained by the alignment of each trial. the line indicates the
%presence of the stimulus. The axes are appropriately labeled.
imagesc(cat(2,preMatrix,postMatrix))
colormap jet
ax = gca;
line([max([YdataTrials.preLength])+1 max([YdataTrials.preLength])+1],ax.YLim,'color','k','linewidth',1.4)
ax.XLabel.String = 'Tracking frame';
ax.YLabel.String = 'Trial #';





