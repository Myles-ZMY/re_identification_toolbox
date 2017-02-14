function [hSplit,vSplit] = splitMatrix( height, width, numHeight, numWidth)
%SPLITMATRIX Summary of this function goes here
%   Detailed explanation goes here

hStep = floor(height/numHeight);
vStep = floor(width/numWidth);

hSplit = [1 hStep:hStep:height];
vSplit = [1 vStep:vStep:width];

end

