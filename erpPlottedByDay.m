clear all, clc
folderPath = 'C:\Users\valen\Desktop\Correlation_pupil';
fileList = getAllTrackingFiles(folderPath);

 %% Calculates Erp Pre for each file (necessarily the mean)
arbitraryLength = 5000;
erpPre = zeros(size(fileList,1), arbitraryLength);
for i=1:size(fileList,1)
    fN = [fileList.filePath{i} filesep fileList.fileName{i}];
    erpPre(i,:) = mean(fileErp(fN,'y',arbitraryLength),1);
end

%% insert Erp Pre data in a suitable table ready for the analysis
t = fileList(:,{'cageID','mouseID','genotype','condition','relativeDate'});
t.erpPre = erpPre;

%categorize some variable for easier indexing
t.genotype = categorical(t.genotype);
t.condition = categorical(t.condition);

% Remove sessions neither both nor delayed and those in which timepoints
% do not match among different cages
t(t.condition=='none',:) = [];
t(t.relativeDate<-3,:) = [];
t(t.relativeDate>2,:) = [];

%% plot individual day erpPRE
genotype = 'KO';
day = 1;
dayMinusThree = t.erpPre(t.genotype == genotype & t.relativeDate == day,:);
for i = 1:size(dayMinusThree,1)
    
   plot(dayMinusThree(i,:), 'color', [1 0.5 0.5], 'linewidth', 0.7);
   if i == 1
      hold on 
   end
end
plot(mean(dayMinusThree,1),'r', 'lineWidth', 3);
hold off

%% plot erp without averaging each session (bad idea)
arbitraryLength = 5000;
fileList.genotype = categorical(fileList.genotype);
fileListA = fileList(fileList.genotype == 'KO' & fileList.relativeDate == 1, :);
b = 0;
for i=1:size(fileListA,1)
    fN = [fileListA.filePath{i} filesep fileListA.fileName{i}];
    temp = fileErp(fN,'y',arbitraryLength);
    
    
       plot(temp');
       if i ==1 
           hold on
       end
      b = b +size(temp,1);
    
end
hold off
