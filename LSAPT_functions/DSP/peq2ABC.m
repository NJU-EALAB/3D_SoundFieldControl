function [b,a,B,A]=peq2ABC(fm,fs,G,Q,type)
%Frank Schultz, FG Audiokommunikation, TU Berlin
%frank.schultz@tu-berlin.de, +49 175 15 49 763, Skype: j0shiiv
%0.00 07.09.2010 init dev
%type A,B,C peq 2nd order
%some used conventions for peqs, calls [b,a]=peq2(fm,fs,Qz,n,Qp,d);
%see calcBiquadCoeff.m for details
%do the prewarping for Q outside the function!
%Frank Schultz, INT / IEF, Uni Rostock
%frank.schultz@uni-rostock.de, +49 175 15 49 763, Skype: j0shiiv
%0.01 2015-10-29
%now also Laplace transfer function able

%Bristow-Johnson, R. (1994): “The equivalence of various methods of computing
%biquad coefficients for audio parametric equalizers”. In Proc. of 97th AES
%Convention, San Fransisco, 3906.

if strcmp(type,'A')         %Symmetrical-Q, this is the most used standard
    g = 10^(abs(G)/20);
    Qz = Q; Qp = Q;
    if G>0
        n = g; d = 1;
    else
        n = 1; d = g;
    end
    [b,a,B,A]=peq2(fm,fs,Qz,n,Qp,d);
elseif strcmp(type,'B')     %HalfPadLoss-Q
    g = 10^(abs(G)/20);
    Qz = Q; Qp = Q;
    if G>0
        n = g/(10^(abs(G)/40)); d = 1/(10^(abs(G)/40));
    else
        n = 1/(10^(abs(G)/40)); d = g/(10^(abs(G)/40));
    end
    [b,a,B,A]=peq2(fm,fs,Qz,n,Qp,d);
elseif strcmp(type,'C')     %Constant-Q
    g = 10^(G/20);
    Qz = Q; Qp = Q;
    n = g; d = 1;
    [b,a,B,A]=peq2(fm,fs,Qz,n,Qp,d);
else
    b=1; a=1;
end
end





