clearvars, clc, close all
data = openTrackFile();
Xcoord = data.x - (data.rect(1)-1);
Ycoord = data.y - (data.rect(2)-1);
Coordinates = cat(2,Xcoord, Ycoord);


[ii,jj,kk]=unique(Coordinates,'rows');
f = histc(kk,1:numel(jj));
out=[ii f];

matrix = zeros(data.rect(3),data.rect(4));
for i = 1:length(out)

    matrix(out(i,1),out(i,2)) = (out(i,3));

end

surf(matrix' + 50);
colormap jet;
hold on
imagesc(matrix')
hold off
%%

data = openTrackFile();
sepTrials = separateTrials(data);
YdataTrials = splitTrials(sepTrials);
XdataTrials = splitTrialsX(sepTrials);
Coordinates2 = [];
Coordinates2(:,1) = cat(1, YdataTrials(:).Ypre);
Coordinates2(:,2) = cat(1, XdataTrials(:).Xpre);

[ii2,jj2,kk2]=unique(Coordinates2,'rows');
f2 = histc(kk2,1:numel(jj2));
out2=[ii2 f2];

matrix = zeros(data.rect(3),data.rect(4));
for i = 1:length(out2)

    matrix2(out2(i,1),out2(i,2)) = (out2(i,3));

end

surf(matrix2' + 50);
colormap jet;
hold on
imagesc(matrix2')
hold off
