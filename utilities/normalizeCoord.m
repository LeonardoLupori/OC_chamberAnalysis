function [normalizedX, normalizedY] = normalizeCoord(x, y, rect)
% normalizedCoord = normalizeCoord(rawCoord, rect)
% 
% Normalize a vector of positions based on the arena rectangle coordinates


% Convert the rect coordinates in [x,y,width,height]
rectNorm = [rect(1), rect(2), rect(3)-rect(1), rect(4)-rect(2)];

% Normalize the coordinates
normalizedX = (x-rectNorm(1)) / rectNorm(3);
normalizedY = (y-rectNorm(2)) / rectNorm(4);

% Check for critical errors
if min(normalizedX) < 0 || min(normalizedY) < 0
    error('Normalization of position vector gave a minimum position lesser than 0')
end
if max(normalizedX) > 1 || max(normalizedY) > 1
    error('Normalization of position vector gave a maximum position greater than 1')
end