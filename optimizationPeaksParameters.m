clear all, clc
folderPath = 'C:\Users\Leonardo\Desktop\Correlation_pupil';
fileList = getAllTrackingFiles(folderPath);

%%
framelength = 101;
smoothing = 7;
MinPeakDistance = 10;
MinPeakProminence = 0.25;
MaxPeakWidth = 100;


indx = randi(size(fileList,1));
fN = [fileList.filePath{indx} filesep fileList.fileName{indx}];

data = openTrackFile(fN);
dataTrials = separateTrials(data);
dataTrials = splitTrials(dataTrials);

trialInd = randi(length(dataTrials));

[~, dataY] = normalizeCoord(dataTrials(trialInd).Xpre, dataTrials(trialInd).Ypre, data.rect);

dataY = dataY(1:end-20);

if length(dataY) < framelength
    framelength = length(dataY) - mod(length(dataY),2) - 1;
end

smoothData =  sgolayfilt(dataY, 7, framelength);

[peaks, loc] = findpeaks(smoothData,...
        'MinPeakDistance', MinPeakDistance,...
        'MinPeakProminence', MinPeakProminence...
        );
    
plot(smoothData)
hold on
plot(loc,peaks,'LineStyle','none','Marker','s','Color','r')
hold off
ylim([0,1.1])
xlim([0, 5000])

str = ['Genotype: ' fileList.genotype{indx} '\tTimepoint: ' fileList.condition{indx} '\n'];
fprintf(str)

    
    