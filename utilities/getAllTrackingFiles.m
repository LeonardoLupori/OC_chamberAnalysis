function fileList = getAllTrackingFiles(folderPath)

if nargin < 1
    path = 'C://';
    tit = 'Select a folder containing all the tracking Data';
    folderPath = uigetdir(path,tit);
end

fileList = struct(...
    'cageID',[],...
    'mouseID',[],...
    'genotype',[],...
    'filePath',[],...
    'fileName',[],...
    'condition',[],...
    'date',[],...
    'relativeDate',[]...
    );

[~, cages] = findSubfolders(folderPath, 'Cage_');
count = 1;
for cage = 1:length(cages)
    currentFolder_cage = [folderPath filesep cages{cage}];
    [~, miceNames] = findSubfolders(currentFolder_cage, '-');
    for animal = 1:length(miceNames)
        curAnimal = miceNames{animal};
        currentFolder = [currentFolder_cage filesep curAnimal];
        % Decode folder name to get Cage, MouseID, and Genotype
        temp = strsplit(curAnimal,'-');
        cageID = temp{1};
        mouseID = temp{2};
        genotype = temp{3};
        
        [~, fileNames] = findFile(currentFolder,'tracker');
        for f = 1:length(fileNames)
            currFile = fileNames{f};
            
            fileList(count).cageID = cageID;
            fileList(count).mouseID = mouseID;
            fileList(count).genotype = genotype;
            fileList(count).filePath = currentFolder;
            fileList(count).fileName = fileNames{f};
            
            temp = strsplit(currFile,'_');
            fileList(count).date = temp{1};
            
            % Determines the experimental condition for that day
            day = temp{1}(end-1:end);
            day = str2double(day);
            [~, names] = findFile(currentFolder,'index');
            if length(names)<1 || length(names)>1
                warning(['None/more than 1 "index" files found for file: ' currFile ' assigned value "none" for condition'])
                condition = 'none';
            else
                indexFileFullPath = [currentFolder filesep names{1}];
                [condition, relDay ]= getConditionFromIndex(indexFileFullPath, day);
            end
            fileList(count).condition = condition;
            fileList(count).relativeDate = relDay;
            
            count = count +1;
        end
    end
end


fileList = struct2table(fileList);






