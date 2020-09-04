function [erpPre, erpPost, erpTot] = fileErp(filename, variable, finalLength)

if nargin < 1
    data = openTrackFile();
    variable = 'y';
    finalLength = 1000;
elseif nargin < 2
    variable = 'y';
    finalLength = 1000;
    data = openTrackFile(filename);
elseif nargin < 3
    finalLength = 1000;
    data = openTrackFile(filename);
else
    data = openTrackFile(filename);
end

trialStruct  = separateTrials(data);
dataTrials = splitTrials(trialStruct);

erpPre = zeros(length(dataTrials), finalLength);
erpPost = zeros(length(dataTrials), finalLength);
erpTot = zeros(length(dataTrials), finalLength);

for i=1:length(dataTrials)
    % Normalize position vectors
    [normXpre, normYPre] = normalizeCoord(dataTrials(i).Xpre, dataTrials(i).Ypre, data.rect);
    [normXpost, normYPost] = normalizeCoord(dataTrials(i).Xpost, dataTrials(i).Ypost, data.rect);
    
    switch variable
        case 'y'
            erpPre(i,:) = bresample(normYPre, finalLength);
            erpPost(i,:) = bresample(normYPost, finalLength);
            totalTrials = [normYPre; normYPost];
            erpTot(i,:) = bresample(totalTrials, finalLength);
        case 'x'
            erpPre(i,:) = bresample(normXpre, finalLength);
            erpPost(i,:) = bresample(normXpost, finalLength);
            totalTrials = [normXpre; normXpost];
            erpTot(i,:) = bresample(totalTrials, finalLength);
        case 'speed'
            spPre = speed(dataTrials(i).Xpre, dataTrials(i).Ypre, dataTrials(i).timePre);
            erpPre(i,:) = bresample(spPre, finalLength);
            
            spPost = speed(dataTrials(i).Xpost, dataTrials(i).Ypost, dataTrials(i).timePost);
            erpPost(i,:) = bresample(spPost, finalLength);
            
            erpTot(i,:) = bresample([spPre;spPost], finalLength);
    end
end















