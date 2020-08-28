function normalizedCoord = normalizeCoord(rawCoord, rect)
% normalizedCoord = normalizeCoord(rawCoord, rect)
% 
% Normalize a vector of positions based on the arena rectangle coordinates
% [x y width height]


normalizedCoord = (rawCoord - rect(2))/rect(4);

% Check for critical errors
if min(normalizedCoord(:)) < 0
    error('Normalization of position vector gave a minimum position lesser than 0')
end
if max(normalizedCoord(:)) > 1
    error('Normalization of position vector gave a maximum position greater than 1')
end