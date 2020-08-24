function ErpMatrix = erpPostTrials(filename, finalLength)
%the function accepts the filename as an argument and returns a matrix
%containing all the pre-stimulus trials. Each trial is resampled to a total length of finalLength.
%see also: openTrackFile, separateTrials, splitTrials

if nargin <1
    data = openTrackFile();
    finalLength = 1000;
elseif nargin<2
    finalLength = 1000;
    data = openTrackFile(filename);
else
    data = openTrackFile(filename);
end

TrialStruct  = separateTrials(data);
YdataTrials = splitTrials(TrialStruct);
%resample pre-stimulus data

%preallocate the matrix
ErpMatrix = zeros(length(YdataTrials), finalLength);
for i = 1:length(YdataTrials)
  ErpMatrix(i,:) = bresample(YdataTrials(i).Ypost, finalLength);
end

ErpMatrix = ErpMatrix';
%normalize the values in the matrix
ErpMatrix = (ErpMatrix - double(data.rect(2)))./double(data.rect(4) - data.rect(2));
end
