%% open files
%the script creates 2 4D matrices for the 2 genotypes. the 1st dimention
%contains each day, the 2nd dimention the resampled mean of all the trials of the session,
% the 3rd dimension all the sessions recorded in that day, the 4th
% dimension represents each mouse.


startF = 'C:\Users\valen\Desktop\MATLAB_NEURO\TESI\';
seldir =  uigetdir(startF);

[~, nameSubfolder] = findSubfolders(seldir, '_');
WTmatrix = zeros(8, 1000, 3, 3);
KOmatrix = zeros(8, 1000, 3, 4);
WTmiceCounter = 1;
KOmiceCounter = 1;
for i = 1:length(nameSubfolder)
    sf = [seldir '\' nameSubfolder{i}] ;
    [~, nameSubfolder2A] = findSubfolders(sf, 'WT');
    
    for k = 1:length(nameSubfolder2A)
        sf2 = [sf '\' nameSubfolder2A{k}] ;
        [~, nameFile1] = findFile(sf2, 'txt');
        sessionIndex = 1;
        dayIndex = 1;
        for j =  1:length(nameFile1)
            currF = [sf2 '\' nameFile1{j}];
            tempFileN = split(nameFile1{j},'_');
            WTmatrix(dayIndex, :, sessionIndex, WTmiceCounter) = mean(erpPreTrials(currF),2);
            if j ~= length(nameFile1)
                controlfile = split(nameFile1{j+1},'_');
                if strcmp(controlfile{1},tempFileN{1}) == 1
                    sessionIndex =  sessionIndex+1;
                elseif strcmp(controlfile{1},tempFileN{1}) == 0
                    dayIndex = dayIndex+1;
                    sessionIndex = 1;
                end
            end
        end
        WTmiceCounter = WTmiceCounter+1;
    end
    
    [~, nameSubfolder2B] = findSubfolders(sf, 'KO');
    
    for k = 1:length(nameSubfolder2B)
        sf3 = [sf '\' nameSubfolder2B{k}] ;
        [~, nameFile2] = findFile(sf3, 'txt');
        sessionIndex = 1;
        dayIndex = 1;
        for j =  1:length(nameFile2)
            currF = [sf3 '\' nameFile2{j}];
            tempFileN = split(nameFile2{j},'_');
            KOmatrix(dayIndex, :, sessionIndex, KOmiceCounter) = mean(erpPreTrials(currF),2);
            if j ~= length(nameFile1)
                controlfile = split(nameFile1{j+1},'_');
                if strcmp(controlfile{1},tempFileN{1}) == 1
                    sessionIndex =  sessionIndex+1;
                elseif strcmp(controlfile{1},tempFileN{1}) == 0
                    dayIndex = dayIndex+1;
                    sessionIndex = 1;
                end
            end
            
        end
        KOmiceCounter = KOmiceCounter+1;
        
    end
end
%% plot erpPre of the 2 genotype conditions
% WTmatrix_mean = mean(mean(WTmatrix,3),4);
% KOmatrix_mean = mean(mean(KOmatrix,3),4);
% 
WTmatrix_mean = mean(WTmatrix,3);
KOmatrix_mean = mean(KOmatrix,3);

% WTmatrix_mean = WTmatrix_mean(:,:,:,3);
KOmatrix_mean = KOmatrix_mean(:,:,:,4);


LW = 1.2;
% plot two matrices
ax1 = subplot(2,2,1);
ax1.ColorOrder = jet(4);
ax1.NextPlot = 'ReplaceChildren';
plot(ax1, WTmatrix_mean(1:4, :)', 'LineWidth', LW);
ax1.YLim = [0 1];
ax1.XLabel.String = 'normalized trial duration (au)';
ax1.YLabel.String = 'normalized y position';
ax1.Title.String = 'WT both';
legend({'1st day','2nd day','3rd day','4th day'},'Location','best');

ax2 = subplot (2,2,2);
ax2.ColorOrder = jet(4);
ax2.YLim = [0 1];
ax2.XLabel.String = 'normalized trial duration (au)';
ax2.YLabel.String = 'normalized y position';
ax2.Title.String = 'KO both';
ax2.NextPlot = 'ReplaceChildren';
plot(ax2, KOmatrix_mean(1:4, :)','LineWidth', LW);

ax3 = subplot(2,2,3);
ax3.ColorOrder = jet(4);
ax3.NextPlot = 'ReplaceChildren';
plot(ax3, WTmatrix_mean(5:8, :)', 'LineWidth', LW);
ax3.YLim = [0 1];
ax3.XLabel.String = 'normalized trial duration (au)';
ax3.YLabel.String = 'normalized y position';
ax3.Title.String = 'WT delay';

% 
ax4 = subplot (2,2,4);
ax4.ColorOrder = jet(4);
ax4.YLim = [0 1];
ax4.XLabel.String = 'normalized trial duration (au)';
ax4.YLabel.String = 'normalized y position';
ax4.Title.String = 'KO delay';
ax4.NextPlot = 'ReplaceChildren';
plot(ax4, KOmatrix_mean(5:8, :)', 'LineWidth', LW);

