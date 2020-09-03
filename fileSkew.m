function skewnessFile = fileSkew(filename)
%skewnessFile = fileSkew(filename)
%
%given the tracking file path,the function returns the average skewness of the file

if nargin <1
    data = openTrackFile();
elseif nargin<2
    data = openTrackFile(filename);
else
    data = openTrackFile(filename);
end


TrialStruct  = separateTrials(data);
dataTrials = splitTrials(TrialStruct);
skewTrackTrials = [];
normVec = [];

for i = 1:length(YdataTrials)
    normVec = normalizeCoord(dataTrials(i).Ypre, data.rect);
    %normVec = (dataTrials(i).Ypre  - double(data.rect(2)))./double(data.rect(4) - data.rect(2));
    skewTrackTrials(i,1) =  skewness(normVec(1:end)) ;
end

skewnessFile = mean(skewTrackTrials);
end