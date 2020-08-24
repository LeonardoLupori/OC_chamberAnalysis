function SpeedMatrix = meanSpeedFile(filename, finalLength)


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
% velocityVec = zeros(length(YdataTrials),1);
SpeedMatrix = zeros(length(YdataTrials),finalLength);
for i = 1:length(YdataTrials)
   YdataTrials(i).YtimePre = YdataTrials(i).YtimePre - YdataTrials(i).YtimePre(1);
   velocityVec(i,:) = YdataTrials(i).Ypre ./ YdataTrials(i).YtimePre;
   SpeedMatrix(i,:) = bresample(velocityVec(i,:), finalLength);
    
end
% 
% SpeedMatrix = SpeedMatrix';

end