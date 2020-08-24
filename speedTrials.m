function speedTrialsCell = speedTrials(XdataTrials, YdataTrials)
%speedTrialsCell = speedTrials(XdataTrials, YdataTrials)
%
%the function returns a n-by-6 cell array containing the module of the
%velocity vector of the mouse before (1rst column) and qfter (2nd column) the
%activation of each of the n trials. The sign of the speed is stored in the
%remaining columns: 3,4 sign of pre-trial speed (along x and y dimension respectively);
%5,6 sign of post-trial speed (along x and y dimension respectively).



speedTrialsCell = cell(length(YdataTrials),6);

for i = 1:length(YdataTrials)
speedXaxis_Pre = [0; diff(XdataTrials(i).Xpre)];
speedYaxis_Pre = [0; diff(YdataTrials(i).Ypre)];
speedTrialsCell{i,1} = hypot(speedXaxis_Pre, speedYaxis_Pre);

speedTrialsCell{i,3} = sign(speedXaxis_Pre);
speedTrialsCell{i,4} = sign(speedXaxis_Pre);

speedXaxis_Post = [0; diff(XdataTrials(i).Xpost)];
speedYaxis_Post = [0; diff(YdataTrials(i).Ypost)];
speedTrialsCell{i,2}= hypot(speedXaxis_Post, speedYaxis_Post);

speedTrialsCell{i,5} = sign(speedXaxis_Post);
speedTrialsCell{i,6} = sign(speedXaxis_Post);

end
end