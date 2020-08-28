%% create 3D matrix
%the x contains the average trial of one session, the Y all the average trials of
%the mouse, the z all the mice.
startF = 'C:\Users\valen\Desktop\MATLAB_NEURO\TESI\';
seldir =  uigetdir(startF);
totLength = 1000;
[logicalList1, nameSubfolder] = findSubfolders(seldir, '-');
ErpPreMatrix = zeros(8,1000,length(nameSubfolder));
ErpPostMatrix = zeros(8,1000,length(nameSubfolder));
for i = 1:length(nameSubfolder)
    sf = [seldir '\' nameSubfolder{i}] ;
    [logicalList2, nameFile] = findFile(sf, 'txt');
    
    for j =  1:length(nameFile)
        currF = [sf '\' nameFile{j}];
        
        ErpPreTemp = erpPreTrials(currF, totLength);
        ErpPreMatrix(j,:,i) = mean(ErpPreTemp,2);
        
        ErpPostTemp = erpPostTrials(currF, totLength);
        ErpPostMatrix(j,:,i) = mean(ErpPostTemp,2);
        
    end
end
close all;
% plot two matrices
ax = subplot(1,2,1);
ax.ColorOrder = jet(8);
ax.NextPlot = 'ReplaceChildren';
plot(mean(ErpPreMatrix,3)');
ax.YLim = [0 1];
ax.XLabel.String = 'normalized trial duration (au)';
ax.YLabel.String = 'normalized y position';
ax.Title.String = 'pre-stimulus';
legend({'1st session','2nd session','3rd session','4th session',...
    '5th session','6th session','7th session','8th session'},'Location','best')
ax1 = subplot (1,2,2);
ax1.ColorOrder = jet(8);
ax1.YLim = [0 1];
ax1.XLabel.String = 'normalized trial duration (au)';
ax1.YLabel.String = 'normalized y position';
ax1.Title.String = 'post-stimulus';
ax1.NextPlot = 'ReplaceChildren';
plot(mean(ErpPostMatrix,3)');










