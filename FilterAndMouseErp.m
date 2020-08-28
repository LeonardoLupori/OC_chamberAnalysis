%% filter as image
%the following script filters the high frequencies of the track.
%it exploits imfilter, although this function was designed for
%images (which are matrices indeed)

fS = 21;
kernel = ones(fS,1)*(1/fS);
erp = erpPreTrials();

subplot 121
plot(erp)
ylim([0 1])
subplot 122
plot(imfilter(erp,kernel,'replicate'))
ylim([0 1])
%% plot the erp of each file in a suitable colormap
%the colors highlight the advancement in time of the average plot of each
%file. Basically the resulting graph  refers to the entire folder of the
%mouse.

startF = 'C:\Users\valen\Desktop\MATLAB_NEURO\TESI\data_track';
[fN,path] = uigetfile([startF '/*'],'multiselect','on');
totLength = 1000;
sessionsERP = zeros(totLength,size(fN,2));

for i = 1:length(fN)
    currentFile  = [path fN{i}];
    ErpMatrix = erpPreTrials(currentFile, totLength);
    sessionsERP(:,i) = mean(ErpMatrix,2);
end

ax = axes;
ax.ColorOrder = jet(8);
ax.NextPlot = 'ReplaceChildren';
plot(ax,sessionsERP,'LineWidth',1.5);


