%% histcount, frequencies of y positions.

startF = 'C:\Users\valen\Desktop\MATLAB_NEURO\TESI\';
seldir =  uigetdir(startF);

[~, nameSubfolder] = findSubfolders(seldir, '_');
edges = 0:0.05:1;
WTmatrix = zeros(8, length(edges) - 1, 3, 2);
KOmatrix = zeros(8, length(edges) - 1, 3, 4);

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
            WTmatrix(dayIndex, :, sessionIndex, WTmiceCounter) = countSessionFrequency(currF, edges);
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
            KOmatrix(dayIndex, :, sessionIndex, KOmiceCounter) = countSessionFrequency(currF, edges);
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
%%
WTmatrixS = squeeze(sum(WTmatrix,3));
KOmatrixS = squeeze(sum(KOmatrix,3));

WTmatrixS = sum(WTmatrixS,3);
KOmatrixS = sum(KOmatrixS,3);

for i = 1:8
a = subplot(2,4,i) ;
histogram('binedges', edges, 'bincounts', WTmatrixS(i,:),'normalization', 'probability')
a.Title.String = sprintf('Day # %u', i);
a.YLabel.String = 'Probability';
a.XLabel.String = 'Normalized Y position';

hold on
histogram('binedges', edges, 'bincounts', KOmatrixS(i,:),'normalization', 'probability')
hold off
end