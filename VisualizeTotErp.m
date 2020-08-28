%% erp of total trial
% same as pre-post stimuls, but with the whole length of the trial
%see 3dimmatrix.m
close all

startF = 'C:\Users\valen\Desktop\MATLAB_NEURO\TESI\';
seldir =  uigetdir(startF);
totLength = 1000;
[logicalList1, nameSubfolder] = findSubfolders(seldir, '-');
ErpTotMatrix = zeros(8,2000,length(nameSubfolder));

for i = 1:length(nameSubfolder)
    sf = [seldir '\' nameSubfolder{i}] ;
    [logicalList2, nameFile] = findFile(sf, 'txt');
    
    for j =  1:length(nameFile)
        currF = [sf '\' nameFile{j}];
        
        ErpTotTemp = erpTotTrials(currF, totLength);
        ErpTotMatrix(j,:,i) = mean(ErpTotTemp,2);
               
    end
end

ax = axes;
ax.ColorOrder = jet(8);
ax.NextPlot = 'ReplaceChildren';
plot(mean(ErpTotMatrix,3)');
ax.YLim = [0 1];
ax.XLabel.String = 'normalized trial duration (au)';
ax.YLabel.String = 'normalized y position';
ax.Title.String = 'pre-post stimulus';
% legend({'1st session','2nd session','3rd session','4th session',...
%     '5th session','6th session','7th session','8th session'},'Location','best')