function numOfPeaks = countPeaks(filename)
%numOfPeaks = countPeaks(filename)
%
%the function returns a columnar array containing the presumnptive number
%of peaks in the pre-trial Y coordinates of all the trials contained in a
%txt file (single session of the behavioral test).

if nargin <1
    data = openTrackFile();
else
    data = openTrackFile(filename);
end

sepdata = separateTrials(data);
YdataTrials = splitTrials(sepdata);
numOfPeaks = zeros(length(YdataTrials),1);
temp= [];
framelength = 175;
for i = 1:length(YdataTrials)
    YdataTrials(i).Ypre = (YdataTrials(i).Ypre - data.rect(2))/data.rect(4);
    if length(YdataTrials(i).Ypre) < framelength
      framelength = length(YdataTrials(i).Ypre) - mod(length(YdataTrials(i).Ypre),2) - 1;
    end
    smoothData =  sgolayfilt(YdataTrials(i).Ypre, 7, framelength);
    temp = findpeaks(smoothData, 'MinPeakDistance', 10 , 'MinPeakProminence', 0.13);
    sz = size(temp);
    if sz(1) == 0;
        numOfPeaks(i,1) = 0;
    else
        numOfPeaks(i,1) = length(temp);
    end
end


end