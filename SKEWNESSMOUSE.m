startF = 'C:\Users\valen\Desktop\MATLAB_NEURO\TESI\';
seldir =  uigetdir(startF);

[~, nameSubfolder] = findSubfolders(seldir, '_');
MouseCounter = 1;
skewMatrix = zeros(24,6);
for i = 1:length(nameSubfolder)
    sf = [seldir '\' nameSubfolder{i}] ;
    [~, nameSubfolder2A] = findSubfolders(sf, 'WT');
    
    for k = 1:length(nameSubfolder2A)
        sf2 = [sf '\' nameSubfolder2A{k}] ;
        [~, nameFile1] = findFile(sf2, 'txt');
     
        for j =  1:length(nameFile1)
            currF = [sf2 '\' nameFile1{j}];
            skewMatrix(j, MouseCounter) = fileSkew(currF);
                    
        end
        MouseCounter = MouseCounter+1;
    end
    
    [~, nameSubfolder2B] = findSubfolders(sf, 'KO');
    
    for k = 1:length(nameSubfolder2B)
        sf3 = [sf '\' nameSubfolder2B{k}] ;
        [~, nameFile2] = findFile(sf3, 'txt');
        
        for j =  1:length(nameFile2)
            currF = [sf3 '\' nameFile2{j}];
            skewMatrix(j, MouseCounter) = fileSkew(currF);
                        
        end
        MouseCounter = MouseCounter+1;
        
    end
end
DayMatrix = zeros(8,6);

DayMatrix(1,:) = mean(skewMatrix(1:3  , :), 1);
DayMatrix(2,:) = mean(skewMatrix(4:6  , :), 1);
DayMatrix(3,:) = mean(skewMatrix(7:9  , :), 1);
DayMatrix(4,:) = mean(skewMatrix(10:12, :), 1);
DayMatrix(5,:) = mean(skewMatrix(13:15, :), 1);
DayMatrix(6,:) = mean(skewMatrix(16:18, :), 1);
DayMatrix(7,:) = mean(skewMatrix(19:21, :), 1);
DayMatrix(8,:) = mean(skewMatrix(22:24, :), 1);


plot(mean(DayMatrix(:,[1 5]),2),'r');
hold on
plot(mean(DayMatrix(:,[2 3 4 6]),2), 'b');
hold off
