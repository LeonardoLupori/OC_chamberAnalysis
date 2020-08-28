samplesToIgnore = 100;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Opens the file
data = openTrackFile();
% Make sure only one figure appears
if exist('figGeneral','var') && ishandle(figGeneral)
    close(figGeneral)
end
figGeneral = figure;
axG = axes;
% Plot the tracking
track = plot(data.x(samplesToIgnore:end),data.y(samplesToIgnore:end),'k');
hold on
rect = data.rect;
box = rectangle('Position', [rect(1) rect(2) rect(3)-rect(1) rect(4)-rect(2)],...
    'edgecolor','r','linewidth',2);
threshold = line([rect(1) rect(3)], [(rect(2)+rect(4))/2 (rect(2)+rect(4))/2],...
    'color','b','linewidth',2);
% Set the axes to start from 0
axG.XLim(1) = 0;
axG.YLim(1) = 0;
axis square

legend([track threshold],{'Mouse tracking','Active threshold'},...
    'Location','best')
st = strsplit(data.filename,'\');
axG.Title.String = st{end};
axG.Title.Interpreter = 'none';



