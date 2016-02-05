function [ point3 ] = pointTransfer( Tri, point1, point2 )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    point3 = zeros(3,1);
    i = 1;
    j = 2;
    
    for l=1:3,
        v1 = 0;
        v2 = 0;
        for k=1:3,
            v1 = v1+point1(k)*Tri(k,j,l);
            v2 = v2+point1(k)*Tri(k,i,l);
        end;
        
        point3(l) = point2(i)*v1 - point2(j)*v2;
    end;
end

