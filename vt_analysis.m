clear all, clc
folderPath = 'C:\Users\valen\Desktop\chemogenetics01';
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
% initialized(i) = fileSkew(fN);
end

% % Example functions
% fileSkew(fN)
% fileErp(fN,'y',1000)

%% Build the final Table
t = fileList(:,{'cageID','mouseID','genotype','condition','relativeDate'});

t.Peaks = initialized;
% Categorize some variables for easier indexing
t.genotype = categorical(t.genotype);
t.condition = categorical(t.condition);
% Remove sessions neither both nor delayed
t(t.condition=='none',:) = [];
t(t.relativeDate <-4,:) = [];
t(t.relativeDate > 3,:) = [];

%% get mean data for each mouse
id = strcat(t.cageID(:),'_' ,t.mouseID(:));
t.id = id;
% Divide the table t in experimental groups
[G, id, geno, cond, relDate] = findgroups(t.id, t.genotype,t.condition,t.relativeDate);

% Apply functions to the groups
totalFailed = splitapply(@mean,t.Peaks,G);
%output table
t_output = table(id, geno,cond,relDate,totalFailed);
% t_output.mouse = strcat(t_output.cage(:), t_output.mousename(:));
% t_output.mousename = [];
% t_output.cage = [];
% t_output = movevars(t_output, 'mouse', 'Before', 'geno');
% a = t_output(t_output.geno == 'WT', :);
% b = t_output(t_output.geno == 'KO', :);

%% Data analysis for UNIDIMENSIONAL VARIABLES

% Define custom functions
sem = @(x) std(x)/sqrt(numel(x));
N = @(x) numel(x);

% Divide the table t in experimental groups
[G, geno, cond, relDate] = findgroups( t_output.geno,t_output.cond,t_output.relDate);

% Apply functions to the groups
means= splitapply(@mean,t_output.totalFailed,G);
stdErr = splitapply(sem,t_output.totalFailed,G);
numero = splitapply(N,t_output.totalFailed,G);

% Build another table with the result of the functions
t_output_graph = table(geno,cond,relDate,means, stdErr, numero);



%% Plot The data

genotypes = unique(t_output_graph.geno);
ax = axes;

% Initialize an array of handles for plots
plt = zeros(length(genotypes),1);

for i = 1:length(genotypes)
    % X values are the relative dates
    x = t_output_graph.relDate(t_output_graph.geno == genotypes(i));
    % Y values are the means
    y = t_output_graph.means(t_output_graph.geno == genotypes(i));
    % Error values
    err = t_output_graph.stdErr(t_output_graph.geno == genotypes(i));
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
%% Save file for Giulia
writetable(t_output,[folderPath filesep 'perseverations_chemogenetic.xls'])

