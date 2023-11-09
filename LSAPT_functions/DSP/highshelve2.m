function [b,a,B,A]=highshelve2(fg,fs,Qz,n1,n2,Qp,d1,d2)
%Frank Schultz, FG Audiokommunikation, TU Berlin
%frank.schultz@tu-berlin.de, +49 175 15 49 763, Skype: j0shiiv
%0.00 06.09.2010 init dev
%Frank Schultz, INT / IEF, Uni Rostock
%frank.schultz@uni-rostock.de, +49 175 15 49 763, Skype: j0shiiv
%0.01 2015-10-21 Frac Int/Diff Prepared
%now also Laplace transfer function able
%see calcBiquadCoeff.m for details
    %analog:
    wg = 2*pi*fg;
    B(1) = n2/wg/wg;			
    B(2) = 1/wg/Qz*n1;		
    B(3) = 1;
    A(1) = d2/wg/wg;	
    A(2) = 1/wg/Qp*d1;	
    A(3) = 1;    

    %digital:
    wg=2*fs*tan(pi*fg/fs); %pre-warping
    BPre(1) = n2/wg/wg;			
    BPre(2) = 1/wg/Qz*n1;		
    BPre(3) = 1;
    APre(1) = d2/wg/wg;	
    APre(2) = 1/wg/Qp*d1;	
    APre(3) = 1;
    [b,a] = calcBiquadCoeff(BPre,APre,fs);
end