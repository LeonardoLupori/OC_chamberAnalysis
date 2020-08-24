function results = openTrackFile(filename)
%results = openTrackFile(filename) 
%results is a struct with fields 'time', 'rect', 'x', 'y', 'event', 'filename'
if nargin < 1
[file,path] = uigetfile("C:\Users\valen\Desktop\MATLAB_NEURO\TESI\*");
filename = [path file];
end

file_x = fopen(filename);
sep = '\t';
dataPre = textscan(file_x,['%s' sep '%f' sep '%f' sep '%f' sep '%f'], 1);
data = textscan(file_x,['%f' sep '%f' sep '%f' sep '%s']);
fclose(file_x);

results.rect = [dataPre{2},dataPre{3},dataPre{4},dataPre{5}];
results.time = data{1,1};
results.x = data{1,2};
results.y= data{1,3};
results.event = data{1,4};
results.filename = filename;
end