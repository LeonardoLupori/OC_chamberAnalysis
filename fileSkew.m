function skewnessFile = fileSkew(filename)
% skewnessFile = fileSkew(filename)
%
% given the tracking file path,the function returns the average skewness of 
% the file during the PRE trial

if nargin <1
    data = openTrackFile();
else
    data = openTrackFile(filename);
end

TrialStruct  = separateTrials(data);
dataTrials = splitTrials(TrialStruct);
skewTrackTrials = zeros(length(dataTrials),1);

for i = 1:length(dataTrials)
    [~, normVec] = normalizeCoord(dataTrials(i).Xpre, dataTrials(i).Ypre, data.rect);
    skewTrackTrials(i,1) =  skewness(normVec) ;
end

skewnessFile = mean(skewTrackTrials);
end