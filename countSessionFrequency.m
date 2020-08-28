function freqVect =  countSessionFrequency(filename,edges)
%freqVect =  countSessionFrequency(filename,edges)
%

if nargin <1
    data = openTrackFile();
    edges = 0:0.05:1;
elseif nargin<2
    edges = 0:0.05:1;
    data = openTrackFile(filename);
else
    data = openTrackFile(filename);
end

TrialStruct  = separateTrials(data);
YdataTrials = splitTrials(TrialStruct);

PreVect = cat(1, YdataTrials(:).Ypre);
PreVect = (PreVect -data.rect(2))./(data.rect(4) - data.rect(2));
% [freqVect,~] = histcounts(PreVect, edges);
[freqVect,~] = histcounts(PreVect(1:end-40), edges);
end