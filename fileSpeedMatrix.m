function SpeedMatrix = fileSpeedMatrix(filename, finalLength)
%SpeedMatrix = fileSpeedMatrix(filename, finalLength)
%
%the function returns a matrix containing the module of the 'speed vector'
%of the mouse computed point by point. Individual rows contain the speed
%values computed for a single trial. The vector is finally resampled to
%finalLength in order to fit the matrix. The output matrix contains
%information of a single file.

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
dataTrials = splitTrials(TrialStruct);
% velocityVec = zeros(length(YdataTrials),1);
SpeedMatrix = zeros(length(dataTrials),finalLength);
for i = 1:length(dataTrials)
   dataTrials(i).timePre = dataTrials(i).timePre - dataTrials(i).timePre(1);
   velocityVec(i,:) = dataTrials(i).Ypre ./ dataTrials(i).timePre;
   SpeedMatrix(i,:) = bresample(velocityVec(i,:), finalLength);
    
end
% 
% SpeedMatrix = SpeedMatrix';

end