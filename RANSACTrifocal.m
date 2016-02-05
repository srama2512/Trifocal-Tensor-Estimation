function [Tfinal, matcheper, m, m1 ] = RANSACTrifocal( vpts1, vpts2, vpts3, matchedTriplets )
%Computing the estimated Trifocal tensor using matches1 and matches2

    matcheper = 0;
    iter = 0;
    Tfinal = 0;
    
    m = struct;
    m1 = struct;    
    while matcheper<0.85 && iter<6000,
         
        iter = iter+1;
        %iter
        idx = randi([1, size(matchedTriplets,1)], 6, 1);
        
        m(1).a1 = [vpts1(matchedTriplets(idx(1),1)).Location'; 1];
        m(1).a2 = [vpts2(matchedTriplets(idx(1),2)).Location'; 1];
        m(1).a3 = [vpts3(matchedTriplets(idx(1),3)).Location'; 1];

        m(2).a1 = [vpts1(matchedTriplets(idx(2),1)).Location'; 1];
        m(2).a2 = [vpts2(matchedTriplets(idx(2),2)).Location'; 1];
        m(2).a3 = [vpts3(matchedTriplets(idx(2),3)).Location'; 1];

        m(3).a1 = [vpts1(matchedTriplets(idx(3),1)).Location'; 1];
        m(3).a2 = [vpts2(matchedTriplets(idx(3),2)).Location'; 1];
        m(3).a3 = [vpts3(matchedTriplets(idx(3),3)).Location'; 1];

        m(4).a1 = [vpts1(matchedTriplets(idx(4),1)).Location'; 1];
        m(4).a2 = [vpts2(matchedTriplets(idx(4),2)).Location'; 1];
        m(4).a3 = [vpts3(matchedTriplets(idx(4),3)).Location'; 1];

        m(5).a1 = [vpts1(matchedTriplets(idx(5),1)).Location'; 1];
        m(5).a2 = [vpts2(matchedTriplets(idx(5),2)).Location'; 1];
        m(5).a3 = [vpts3(matchedTriplets(idx(5),3)).Location'; 1];

        m(6).a1 = [vpts1(matchedTriplets(idx(6),1)).Location'; 1];
        m(6).a2 = [vpts2(matchedTriplets(idx(6),2)).Location'; 1];
        m(6).a3 = [vpts3(matchedTriplets(idx(6),3)).Location'; 1];
        
        lamb1 = ([m(1).a1, m(2).a1, m(3).a1]);
        lambda1 = lamb1\m(4).a1;
        lamb2 = ([m(1).a2, m(2).a2, m(3).a2]);
        lambda2 = lamb2\m(4).a2;
        lamb3 = ([m(1).a3, m(2).a3, m(3).a3]);
        lambda3 = lamb3\m(4).a3;
        
        B1 = ([lambda1(1)*m(1).a1, lambda1(2)*m(2).a1, lambda1(3)*m(3).a1]);
        B2 = ([lambda2(1)*m(1).a2, lambda2(2)*m(2).a2, lambda2(3)*m(3).a2]);
        B3 = ([lambda3(1)*m(1).a3, lambda3(2)*m(2).a3, lambda3(3)*m(3).a3]);
        
        w1 = int16(1);
        w2 = int16(1);
        w3 = int16(1);
        w4 = int16(1);
        w5 = int16(1);
        w6 = int16(1);
        
        if(rcond(lamb1) < 0.0000001 || isnan(rcond(lamb1)))
            w1 = int16(0);
        end;
        if(rcond(lamb2) < 0.0000001 || isnan(rcond(lamb2)))
            w2 = int16(0);
        end;
        if(rcond(lamb3) < 0.0000001 || isnan(rcond(lamb3)))
            w3 = int16(0);
        end;
        if(rcond(B1) < 0.0000001 || isnan(rcond(B1)))
            w4 = int16(0);
        end;
        if(rcond(B2) < 0.0000001 || isnan(rcond(B2)))
            w5 = int16(0);
        end;
        if(rcond(B3) < 0.0000001 || isnan(rcond(B3)))
            w6 = int16(0);
        end;
        
        if(w1 && w2 && w3 && w4 && w5 && w6)
         
            Tri = getTrifocal(m(1), m(2), m(3), m(4), m(5), m(6));

            matcheper1 = getErrorTrifocal(vpts1, vpts2, vpts3, matchedTriplets, Tri);
            iter = iter + 1;
            if(matcheper1 > matcheper)
                Tfinal = Tri;
                matcheper = matcheper1;
            end;
            if(matcheper < 0.85 && matcheper > 0.70)
                m1 = m;
            end;
            %matcheper
        end;
        fprintf('Iteration: %d Best percentage: %f\n', iter,matcheper);
    end;
end

