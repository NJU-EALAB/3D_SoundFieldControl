function [b,a,B,A]=lowshelve2ABC(fg,fs,G,type)
%Frank Schultz, FG Audiokommunikation, TU Berlin
%frank.schultz@tu-berlin.de, +49 175 15 49 763, Skype: j0shiiv
%0.00 06.09.2010 init dev
%Frank Schultz, INT / IEF, Uni Rostock
%frank.schultz@uni-rostock.de, +49 175 15 49 763, Skype: j0shiiv
%0.01 2015-10-21 Frac Int/Diff Prepared
%now also Laplace transfer function able
%type A,B,C lowshelves 2nd order with Butterworth-quality
%see calcBiquadCoeff.m for details
    if strcmp(type,'A')
        g = 10^(abs(G)/20);
        Q = 1/sqrt(2); Qp = Q; Qz = Q;
        if G>0
            n1 = sqrt(g); n2 = g; d1 = 1; d2 = 1;      
        else
            n1 = 1; n2 = 1; d1 = sqrt(g); d2 = g;
        end
        [b,a,B,A]=lowshelve2(fg,fs,Qz,n1,n2,Qp,d1,d2);
    elseif strcmp(type,'B')
        %****************************
        %[4.10, Sch16], [4.11, Sch16]
        %****************************
        g = 10^(abs(G)/20);
        Q = 1/sqrt(2); Qp = Q; Qz = Q;
        if G>0
            n1 = g^(+1/4); n2 = g^(+1/2); d1 = g^(-1/4); d2 = g^(-1/2);      
        else
            n1 = g^(-1/4); n2 = g^(-1/2); d1 = g^(+1/4); d2 = g^(+1/2);
        end
        [b,a,B,A]=lowshelve2(fg,fs,Qz,n1,n2,Qp,d1,d2);
    elseif strcmp(type,'C') %this is LinkwitzTransform
        g = 10^(-abs(G)/20);
        Q = 1/sqrt(2); Qp = Q; Qz = Q;
        if G>0
            n1 = 1; n2 = 1; d1 = sqrt(g); d2 = g;
        else
            n1 = sqrt(g); n2 = g; d1 = 1; d2 = 1;      
        end
        [b,a,B,A]=lowshelve2(fg,fs,Qz,n1,n2,Qp,d1,d2);
    else
       b=1; a=1; 
    end
end





