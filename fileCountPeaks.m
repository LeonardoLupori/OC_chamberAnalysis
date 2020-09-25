function numOfPeaks = fileCountPeaks(filename,framelength)
% numOfPeaks = countPeaks(filename)
%
% the function returns a columnar array containing the presumnptive number
% of peaks in the pre-trial Y coordinates of all the trials contained in a
% txt file (single session of the behavioral test).

% Import data
if nargin < 1
    data = openTrackFile();
    framelength = 101;
elseif nargin < 2
    framelength = 101;
    data = openTrackFile(filename);
else
    data = openTrackFile(filename);
end

% Preprocess data
dataTrials = separateTrials(data);
dataTrials = splitTrials(dataTrials);

numOfPeaks = zeros(length(dataTrials),1);

for i = 1:length(dataTrials)
    [~, yNormalized] = normalizeCoord(dataTrials(i).Xpre, dataTrials(i).Ypre, data.rect);
    
    yNormalized = yNormalized(1:end-20);
    
    if length(yNormalized) < framelength
        framelength = length(yNormalized) - mod(length(yNormalized),2) - 1;
    end
    
    smoothData =  sgolayfilt(dataTrials(i).Ypre, 7, framelength);
    
    temp = findpeaks(smoothData,...
        'MinPeakDistance', 10,...
        'MinPeakProminence', 0.25...
        );
    
    numOfPeaks(i,1) = length(temp);
end


end