function speed = fileSpeed(fileName)
% speed = fileSpeedCell(fileName)
%
% Returns a struct containing the speed of the PRE trials for a given
% filename.
% The struct fields are:
% x: speed along the X axis
% y: speed along the Y axis
% euclidean: absolute speed

if nargin <1
    data = openTrackFile();
else
    data = openTrackFile(fileName);
end

TrialStruct  = separateTrials(data);
dataTrials = splitTrials(TrialStruct);

speed = struct('euclidean',[],...
    'x',[],...
    'y',[]);

for i = 1:length(dataTrials)
    deltaX = diff(dataTrials(i).Xpre);
    deltaY = diff(dataTrials(i).Ypre);
    
    deltaT = diff(dataTrials(i).timePre);
    
    speed(i).x = deltaX ./ deltaT;
    speed(i).y = deltaY ./ deltaT;
    
    speed(i).euclidean = hypot(deltaX, deltaY) ./ deltaT;
end

end