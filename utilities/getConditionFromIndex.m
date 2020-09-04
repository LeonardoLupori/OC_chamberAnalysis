function [condition, relativeDay] = getConditionFromIndex(indexFilePath, currentDay)
% condition = getConditionFromIndex(indexFilePath, currentDay)
% 

fID = fopen(indexFilePath);

bothDays = fgetl(fID);
bothDays = strsplit(bothDays,',');
bothDays = cellfun(@str2double,bothDays);

delayedDays = fgetl(fID);
delayedDays = strsplit(delayedDays,',');
delayedDays = cellfun(@str2double,delayedDays);

fclose(fID);

if any(currentDay == bothDays)
    relativeDay = find(currentDay==bothDays) - length(bothDays) - 1;
    condition = 'both';
elseif any(currentDay == delayedDays)
    relativeDay = find(currentDay==delayedDays) - 1;
    condition = 'delayed';
else
    relativeDay = NaN;
    condition = 'none';
end



