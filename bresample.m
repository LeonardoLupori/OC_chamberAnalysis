
function Result = bresample(Vector, Fs)
% Result = bresample(Vector, Fs)
% if Fs is omitted, the function assumes output size = 100


if nargin < 2
 Fs = 100;
end
sz = length(Vector);
xx = linspace(1,sz,Fs); 

 Result = spline(1:sz,Vector, xx);
end





