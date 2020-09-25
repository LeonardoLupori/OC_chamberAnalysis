clear all, clc
folderPath = 'C:\Users\Leonardo\Desktop\Correlation_pupil';
fileList = getAllTrackingFiles(folderPath);

%% Calculates the desired statistics for each file

% 1 - Initialize an array (array or cell) to hold the processed data for
% each file

% initialized = cell(size(fileList,1), 1);
initialized = zeros(size(fileList,1), 1);

for i=1:size(fileList,1)
    fN = [fileList.filePath{i} filesep fileList.fileName{i}];
%     initialized{i} = func(fN);    % <--- Insert the desired Function
    initialized(i) = mean(fileCountPeaks(fN));      % <--- Insert the desired Function
end

% % Example functions
% fileSkew(fN)
% fileErp(fN,'y',1000)

%% Build the final Table
t = fileList(:,{'cageID','mouseID','genotype','condition','relativeDate'});

t.varAnalyzed = initialized;
% Categorize some variables for easier indexing
t.genotype = categorical(t.genotype);
t.condition = categorical(t.condition);
% Remove sessions neither both nor delayed
t(t.condition=='none',:) = [];


%% Data analysis for UNIDIMENSIONAL VARIABLES

% Define custom functions
sem = @(x) std(x)/sqrt(numel(x));
N = @(x) numel(x);

% Divide the table t in experimental groups
[G, geno, cond, relDate] = findgroups(t.genotype,t.condition,t.relativeDate);

% Apply functions to the groups
means= splitapply(@mean,t.varAnalyzed,G);
stdErr = splitapply(sem,t.varAnalyzed,G);
numero = splitapply(N,t.varAnalyzed,G);

% Build another table with the result of the functions
t_output = table(geno,cond,relDate,means, stdErr, numero);



%% Plot The data

genotypes = unique(t_output.geno);
ax = axes;

% Initialize an array of handles for plots
plt = zeros(length(genotypes),1);

for i = 1:length(genotypes)
    % X values are the relative dates
    x = t_output.relDate(t_output.geno == genotypes(i));
    % Y values are the means
    y = t_output.means(t_output.geno == genotypes(i));
    % Error values
    err = t_output.stdErr(t_output.geno == genotypes(i));
    % plot this set of data
    plt(i) = errorbar(x,y,err,'LineWidth',3,'Marker','o',...
        'DisplayName',char(genotypes(i)));
    
    if i==1
        hold on
    end
end

hold off
ax.YLim(1) = 0;
legend('Location','best')





