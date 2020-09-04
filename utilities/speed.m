function speed = speed(x,y,time)
% speed = speed(x,y,time)
% 
% 

deltaX = diff(x);
deltaY = diff(y);
deltaT = diff(time);

speed = hypot(deltaX,deltaY) ./ deltaT;