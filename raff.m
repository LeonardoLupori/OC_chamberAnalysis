x1 = KOmatrix(5,:,1,3)';
x2 = KOmatrix(4,:,3,2)';
x1 = x1-x2;
% x2 = sin(1:1000);
% x2 = x2 - mean(x2(:));

lH = hamming(length(x1));
x1 = x1.*lH;
x2 = x2.*lH;
pad = zeros(7000,1);
x1 = cat(1, pad,x1,pad);
x2 = cat(1, pad,x2,pad);

Fs = length(x1);            % Sampling frequency                    
T = 1/Fs;             % Sampling period       


Y = fft(x1);
L = length(x1);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
plot(f,P1) 
hold on

Y = fft(x2);
L = length(x2);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
plot(f,P1) 

hold off
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')
ax = gca;
%  ax.YScale = 'log';
%  ax.XScale = 'log';
 
 %%
 x1 = KOmatrix(5,:,1,2)';
x2 = KOmatrix(4,:,3,2)';
 
 
 plot(x1-x2);
