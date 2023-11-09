function [b,a,B,A]=peq2(fm,fs,Qz,n,Qp,d)
%Frank Schultz, FG Audiokommunikation, TU Berlin
%frank.schultz@tu-berlin.de, +49 175 15 49 763, Skype: j0shiiv
%0.00 07.09.2010 init dev
%general peq biquad
%Frank Schultz, INT / IEF, Uni Rostock
%frank.schultz@uni-rostock.de, +49 175 15 49 763, Skype: j0shiiv
%0.01 2015-10-29 
%now also Laplace transfer function able
%see calcBiquadCoeff.m for details
wm = 2*pi*fm;
B(1) = 1/wm/wm;
B(2) = 1/wm/Qz*n;
B(3) = 1;
A(1) = 1/wm/wm;
A(2) = 1/wm/Qp*d;
A(3) = 1;

wm=2*fs*tan(pi*fm/fs); %pre-warping
%do the prewarping for Q outside the function!
Btmp(1) = 1/wm/wm;
Btmp(2) = 1/wm/Qz*n;
Btmp(3) = 1;
Atmp(1) = 1/wm/wm;
Atmp(2) = 1/wm/Qp*d;
Atmp(3) = 1;
[b,a] = calcBiquadCoeff(Btmp,Atmp,fs);
end