p = double(YdataTrials(11).Ypre);
p = smooth(p,1,'loess');
plot(p),hold on, 
ax = gca;
line(ax.XLim,[threshold threshold])

%% plot resampled matrix for y positions
%baseline = mean(mean(resampledMatrix(:,1:200),1),2);

resampledMatrix = erpPreTrials();
plot(resampledMatrix, 'color', [.8 .8 1])
hold on
plot(mean(resampledMatrix, 2),'color',[0 0 1],'LineWidth',2)
hold off