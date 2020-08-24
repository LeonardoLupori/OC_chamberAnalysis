close all, clearvars
%% open files
%the script creates 2 4D cells for the 2 genotypes. the 1st dimention
%contains each session, the 2nd dimension the corresondent date in the form
%'aaaammdd', the 3rd dimension separates 'both' and 'delay' tests, the 4th
%dimension represent each mouse.


startF = 'C:\Users\valen\Desktop\MATLAB_NEURO\TESI\';
seldir =  uigetdir(startF);
counterWT = 1;
counterKO = 1;
[~, nameSubfolder] = findSubfolders(seldir, '_');
WTcellMice = cell(4, 2, 2, 3);
KOcellMice = cell(4, 2, 2, 4);

for i = 1:length(nameSubfolder)
    sf = [seldir '\' nameSubfolder{i}] ;
    [logicalList2A, nameSubfolder2A] = findSubfolders(sf, 'WT');
    
    for k = 1:length(nameSubfolder2A)
        sf2 = [sf '\' nameSubfolder2A{k}] ;
        [logicalList3, nameFile1] = findFile(sf2, 'txt');
        
        for j =  1:length(nameFile1)
            currF = [sf2 '\' nameFile1{j}];
            %             data = openTrackFile(currF);
            %             TrialStruct  = separateTrials(data);
            %             YdataTrials = splitTrials(TrialStruct);
            tempFileN = split(nameFile1{j},'_');
            if j <= 12
                WTcellMice{j, 1, 1, counterWT} = mean(erpPreTrials(currF),2);
                WTcellMice{j, 2, 1, counterWT} = tempFileN{1};
            elseif j > 12
                WTcellMice{j-12, 1, 2, counterWT} = mean(erpPreTrials(currF),2);
                WTcellMice{j-12, 2, 2, counterWT} = tempFileN{1};
            end
            
            
        end
        counterWT = counterWT + 1;
    end
    
    [~, nameSubfolder2B] = findSubfolders(sf, 'KO');
    
    for k = 1:length(nameSubfolder2B)
        sf2 = [sf '\' nameSubfolder2B{k}] ;
        [~, nameFile2] = findFile(sf2, 'txt');
        
        for j =  1:length(nameFile2)
            currF = [sf2 '\' nameFile2{j}];
            
            data = openTrackFile(currF);
            TrialStruct  = separateTrials(data);
            YdataTrials = splitTrials(TrialStruct);
            tempFileN = split(nameFile2{j},'_');
            if j <= 12
                KOcellMice{j, 1, 1, counterKO} = YdataTrials;
                KOcellMice{j, 2, 1, counterKO} = tempFileN{1};
            elseif j > 12
                KOcellMice{j-12, 1, 2, counterKO} = YdataTrials;
                KOcellMice{j-12, 2, 2, counterKO} = tempFileN{1};
            end
            
            
        end
        
        counterKO = counterKO + 1;
    end
end

%% mean of each day
% % mean of each day per mouse
% 
% counterWT_Mean = 1;
% counterKO_Mean = 1;
% dates = unique(WTcellMice(:,2,:,:));
% temp = [];
% WTcellMice_resamp = WTcellMice;
% for k = 1:size(WTcellMice,4)
%     a = [];
%     for j = 1:size(WTcellMice,3)
%         for z = 1:size(WTcellMice,1)
%             for q = 1: length(WTcellMice{z,1,})
%             end
%         end
%     end
% end


%% mean of each day
% % mean of each day per mouse
% WTcellMice_Mean = cell(4, 2, 2, 3);
% KOcellMice_Mean = cell(4, 2, 2, 4);
% counterWT_Mean = 1;
% counterKO_Mean = 1;
% dates = unique(WTcellMice(:,2,:,:));
% temp = [];
% for i = 1:length(dates)
%     for k = 1:size(WTcellMice,4)
%         for j = 1:size(WTcellMice,3)
%             for z = 1:size(WTcellMice,1)
%                 if strcmpi(WTcellMice{z,2,j,k}, dates(i))
%                     temp(counterWT_Mean) = z;
%                 end
%             end
%             WTcellMice_Mean{counterWT_Mean,2,j,k} = mean(WTcellMice{[temp],2,j,k}(:).Ypre );
%             counterWT_Mean = counterWT_Mean +1;
%         end
%     end
% end
