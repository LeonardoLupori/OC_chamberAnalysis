function stdFile = fileStd(filename)
%stdFile = fileStd(filename)
%
%given the tracking file path,the function returns the average standard deviation of the file

if nargin <1
    data = openTrackFile();
else
    data = openTrackFile(filename);
end


TrialStruct  = separateTrials(data);
YdataTrials = splitTrials(TrialStruct);
stdTrackTrials = [];
normVec = [];

for i = 1:length(YdataTrials)
    normVec = (YdataTrials(i).Ypre  - double(data.rect(2)))./double(data.rect(4) - data.rect(2));
    stdTrackTrials(i,1) =  std(normVec(1:(end-40))) ;
end

stdFile = mean(stdTrackTrials,'omitnan');
end