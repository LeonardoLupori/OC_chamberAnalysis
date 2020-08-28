function numOfPeaks = countPeaks(filename,framelength)
% numOfPeaks = countPeaks(filename)
%
% the function returns a columnar array containing the presumnptive number
% of peaks in the pre-trial Y coordinates of all the trials contained in a
% txt file (single session of the behavioral test).

% Import data
if nargin < 1
    data = openTrackFile();
    framelength = 175;
elseif nargin < 2
    framelength = 175;
    data = openTrackFile(filename);
else
    data = openTrackFile(filename);
end

% Preprocess data
dataTrials = separateTrials(data);
dataTrials = splitTrials(dataTrials);


numOfPeaks = zeros(length(dataTrials),1);
for i = 1:length(dataTrials)
    dataTrials(i).Ypre = normalizeCoord(dataTrials(i).Ypre, data.rect);
    
    if length(dataTrials(i).Ypre) < framelength
        framelength = length(dataTrials(i).Ypre) - mod(length(dataTrials(i).Ypre),2) - 1;
    end
    
    smoothData =  sgolayfilt(dataTrials(i).Ypre, 7, framelength);
    
    temp = findpeaks(smoothData,...
        'MinPeakDistance', 10,...
        'MinPeakProminence', 0.13...
        );
    
    numOfPeaks(i,1) = length(temp);
end


end