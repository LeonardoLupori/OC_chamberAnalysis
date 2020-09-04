clear all, clc
folderPath = 'C:\Users\Leonardo\Desktop\Correlation_pupil';
fileList = getAllTrackingFiles(folderPath);

%%
skewness = zeros(size(fileList,1), 1);
for i=1:size(fileList,1)
    fN = [fileList.filePath{i} filesep fileList.fileName{i}];
    skewness(i) = fileSkew(fN);
end

%%
t = fileList(:,{'cageID','mouseID','genotype','condition','relativeDate'});
t.skew = skewness;

t.genotype = categorical(t.genotype);
t.condition = categorical(t.condition);

t(t.condition=='none',:) = [];

%%
sem = @(x) std(x)/sqrt(numel(x));
N = @(x) numel(x);

[G, geno, cond, relDate] = findgroups(t.genotype,t.condition,t.relativeDate);
means= splitapply(@mean,t.skew,G);
e = splitapply(sem,t.skew,G);
numero = splitapply(N,t.skew,G);
t_output = table(geno,cond,relDate,means, e, numero);

%%
genotypes = unique(t_output.geno);
ax = axes;
for i = 1:length(genotypes)
    x = t_output.relDate(t_output.geno == genotypes(i));
    y = t_output.means(t_output.geno == genotypes(i));
    plt(i) = plot(x,y,'LineWidth',3,'Marker','o');
    plt(i).DisplayName = char(genotypes(i));
    if i==1
        hold on
    end
end
hold off
ax.YLim(1) = 0;
legend





