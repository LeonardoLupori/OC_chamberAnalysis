function freqVect =  fileHistFrequency(filename,edges)
%freqVect =  fileHistFrequency(filename,edges)
%
%the function returns a vector containing the frequencies of the normalized
%Y coordinates of the PRE-TRIAL components of the file.
%default edges: edges = 0:0.05:1;

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
dataTrials = splitTrials(TrialStruct);

PreVect = cat(1, dataTrials(:).Ypre);
PreVect = normalizeCoord(PreVect,data.rect);
[freqVect,~] = histcounts(PreVect, edges);
%[freqVect,~] = histcounts(PreVect(1:end-40), edges);
%makes no sense since we are not excluding the last 40 values of each
%trials but the last 40 values of the whole session (file)
%Likely an error in the early phases of the code
end