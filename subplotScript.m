% Make sure only one figure appears
if exist('figGeneral','var') && ishandle(figGeneral)
    close(figGeneral)
end
figGeneral = figure;

numOfTrials = size(trialCell,1);

for i=1:numOfTrials
    axG = subplot(4,6,i);
    
    x = trialCell{i,1};
    y = trialCell{i,2};
    track = plot(x,y,'k');
    hold on
    rect = data.rect;
    box = rectangle('Position', [rect(1) rect(2) rect(3)-rect(1) rect(4)-rect(2)],...
        'edgecolor','r','linewidth',2);
    threshold = line([rect(1) rect(3)], [(rect(2)+rect(4))/2 (rect(2)+rect(4))/2],...
        'color','b','linewidth',2);
    % Set the axes to start from 0
    axG.XLim(1) = 0;
    axG.YLim(1) = 0;
    axG.XTick = [];
    axG.YTick = [];
    axis square
    title(['Trial#' num2str(i)])
end