function nopadimage = imremovepadding( image )
%IMREMOVEPADDING Summary of this function goes here
%   Detailed explanation goes here


hR = transl(:,:,1);
hG = transl(:,:,2);
hB = transl(:,:,3);
hR( ~any(hR,2), : ) = [];  %rows
hR( :, ~any(hR,1) ) = [];  %columns
hG( ~any(hG,2), : ) = [];  %row
hG( :, ~any(hG,1) ) = [];  %columns
hB( ~any(hB,2), : ) = [];  %rows
hB( :, ~any(hB,1) ) = [];  %columns
t = cat(3, hR, hG, hB);
end

