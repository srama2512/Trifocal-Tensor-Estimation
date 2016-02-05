function [ d ] = cross4( a, b, c )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

    l1 = det([a(2:4)'; b(2:4)'; c(2:4)']);
    l2 = -det([[a(1),a(3:4)'] ; [b(1),b(3:4)']; [c(1),c(3:4)']]);
    l3 = det([[a(1:2)',a(4)] ; [b(1:2)',b(4)]; [c(1:2)',c(4)]]);
    l4 = -det([a(1:3)' ; b(1:3)'; c(1:3)']);
    d = [l1; l2; l3; l4];
    
end

