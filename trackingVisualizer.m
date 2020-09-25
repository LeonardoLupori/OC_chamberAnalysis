clear all, clc
folderPath = 'C:\Users\Leonardo\Desktop\Correlation_pupil';
fileList = getAllTrackingFiles(folderPath);

%% Select a random recording
indx = randi(size(fileList,1));
fN = [fileList.filePath{indx} filesep fileList.fileName{indx}];

data = openTrackFile(fN);
dataTrials = separateTrials(data);
dataTrials = splitTrials(dataTrials);

% Play a random trial
trialInd = randi(length(dataTrials));
trial = dataTrials(trialInd);

f = figure('Position',[23,591,1873,488]);
axCoord = subplot(1,3,[1,2]);
axCage = subplot(1,3,3);

axCage.DataAspectRatio = [1,1,1];
axCage.XLim = [data.rect(1), data.rect(3)];
axCage.YLim = [data.rect(2), data.rect(4)];
axCage.Box = 'on';
axCage.XTick = []; axCage.YTick = [];


[~, normY] = normalizeCoord(trial.Xpre,trial.Ypre,data.rect);
[pks,locs,Ysmoothed] = OC_peaks(normY(1:end-20));
[~,~,YsmoothedComplete] = OC_peaks(normY);

plot(axCoord,YsmoothedComplete,'Color','b','LineWidth',2)
axCoord.XLabel.String = 'Time [frames]';
axCoord.YLabel.String = 'Y position [normalized]';

axCoord.XLim = [0, length(normY)];
axCoord.XLabel.FontSize = 15; axCoord.YLabel.FontSize = 15;
axCoord.XLabel.FontWeight = 'bold'; axCoord.YLabel.FontWeight = 'bold';
% axCoord.FontSize = 12;
hold(axCoord,'on')

plot(axCoord,locs,pks,'LineStyle','none','Marker','s','Color','r',...
    'LineWidth',1.5)
l = line(axCoord,[0,0],[0,1],'color','k','lineWidth',1.9);
yline(axCoord,0.5)
hold(axCoord,'off')

tail = 60;

for i = 1:length(trial.Ypre)-1
    if ~ishandle(f)
        break
    end
    if i==1
        hold(axCage,'on')
    end
    l.XData = [i,i];
    
    % Cage
    if i>tail
        plot(axCage,trial.Xpre(i-tail:i), trial.Ypre(i-tail:i),'LineWidth',1.7,'color','r');
        hold(axCage,'on')
        plot(axCage,trial.Xpre(i), trial.Ypre(i),'color','g','MarkerFaceColor','g','Marker','s');
    else
        plot(axCage,trial.Xpre(1:i), trial.Ypre(1:i),'LineWidth',1.7,'color','r');
        hold(axCage,'on')
        plot(axCage,trial.Xpre(i), trial.Ypre(i),'color','g','MarkerFaceColor','g','Marker','s');
    end
    axCage.Title.String = sprintf('Frame: %i/%i',i,length(trial.Ypre)-1);   
    
    axCage.XLim = [data.rect(1), data.rect(3)];
    axCage.YLim = [data.rect(2), data.rect(4)];
    axCage.DataAspectRatio = [1,1,1];
    axCage.XTick = []; axCage.YTick = [];
    
    axCage.Box = 'on';
    drawnow
    pause(0.05)     
    hold(axCage,'off')
    
% %     Capture the plot as an image 
%       frame = getframe(f); 
%       im = frame2im(frame); 
%       [imind,cm] = rgb2ind(im,256); 
%       Write to the GIF File 
%       if i == 1 
%           imwrite(imind,cm,filename,'gif', 'Loopcount',inf,'DelayTime',1/40,'Compression','jpeg'); 
%       else 
%           imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',1/40,'Compression','jpeg'); 
%       end 
    
    
end
% close(f)


