startF = 'C:\Users\valen\Desktop\MATLAB_NEURO\TESI\';
seldir =  uigetdir(startF);

[~, nameSubfolder] = findSubfolders(seldir, '_');
MouseCounter = 1;
peakMatrix = zeros(24,6);
miceNames = cell(1,1);
for i = 1:length(nameSubfolder)
    sf = [seldir '\' nameSubfolder{i}] ;
    [~, nameSubfolder2A] = findSubfolders(sf, '-WT');
    
    for k = 1:length(nameSubfolder2A)
        sf2 = [sf '\' nameSubfolder2A{k}] ;
        [~, nameFile1] = findFile(sf2, 'txt');
        
        for j =  1:length(nameFile1)
            currF = [sf2 '\' nameFile1{j}];
            peaksVector = countPeaks(currF);
            peakMatrix(j, MouseCounter) = mean(peaksVector);
            
        end
        miceNames{MouseCounter} = 'WT';
        MouseCounter = MouseCounter+1;
     
    end
    
    [~, nameSubfolder2B] = findSubfolders(sf, '-KO');
    
    for k = 1:length(nameSubfolder2B)
        sf3 = [sf '\' nameSubfolder2B{k}] ;
        [~, nameFile2] = findFile(sf3, 'txt');
        
        for j =  1:length(nameFile2)
            currF = [sf3 '\' nameFile2{j}];
            peaksVector = countPeaks(currF);
            peakMatrix(j, MouseCounter) = mean(peaksVector);
            
        end
        miceNames{MouseCounter} = 'KO';
        MouseCounter = MouseCounter+1;
        
    end
end
%%

DayMatrix = zeros(8,6);

DayMatrix(1,:) = mean(peakMatrix(1:3  , :), 1);
DayMatrix(2,:) = mean(peakMatrix(4:6  , :), 1);
DayMatrix(3,:) = mean(peakMatrix(7:9  , :), 1);
DayMatrix(4,:) = mean(peakMatrix(10:12, :), 1);
DayMatrix(5,:) = mean(peakMatrix(13:15, :), 1);
DayMatrix(6,:) = mean(peakMatrix(16:18, :), 1);
DayMatrix(7,:) = mean(peakMatrix(19:21, :), 1);
DayMatrix(8,:) = mean(peakMatrix(22:24, :), 1);

WTindex = strcmp(miceNames,'WT');
KOindex = strcmp(miceNames,'KO');

plot(mean(DayMatrix(:, WTindex),2),'r');
hold on
plot(mean(DayMatrix(:, KOindex),2), 'b');
hold off
