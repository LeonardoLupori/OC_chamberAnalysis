function [pks,locs,smoothed] = OC_peaks(data)

framelength = 101;
MinPeakDistance = 10;
MinPeakProminence = 0.25;

if length(data) < framelength
    framelength = length(data) - mod(length(data),2) - 1;
end
smoothData =  sgolayfilt(data, 7, framelength);
smoothed = smoothData;

[pks,locs] = findpeaks(smoothData,...
    'MinPeakDistance', MinPeakDistance,...
    'MinPeakProminence', MinPeakProminence...
    );

