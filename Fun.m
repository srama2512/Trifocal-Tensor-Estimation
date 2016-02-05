function [ T ] = Fun( ai, bi, aj, bj, ak, bk )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    T = [ai*aj*ak; ai*aj*bk+ai*bj*ak+ai*aj*ak; ...
         ai*aj*bk+bi*bj*ak+ai*bj*bk; bi*bj*bk];

end

