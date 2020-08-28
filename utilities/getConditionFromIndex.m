function condition = getConditionFromIndex(indexFilePath, currentDay)
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
    condition = 'both';
elseif any(currentDay == delayedDays)
    condition = 'delayed';
else
    condition = 'none';
end



