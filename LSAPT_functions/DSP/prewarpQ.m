function Qpre=prewarpQ(fm,fs,Q,type)
%Frank Schultz, FG Audiokommunikation, TU Berlin
%frank.schultz@tu-berlin.de, +49 175 15 49 763, Skype: j0shiiv
%0.00 07.09.2010 init dev
%Q prewarping for bandpass, bandstop and peq

%Bristow-Johnson, R. (1994): “The equivalence of various methods of computing
%biquad coefficients for audio parametric equalizers”. In Proc. of 97th AES
%Convention, San Fransisco, 3906.

    if strcmp(type,'cos')         
        Qpre = Q*cos(pi*fm/fs);
    elseif strcmp(type,'tan')    
        Qpre = Q*(pi*fm/fs)/(tan(pi*fm/fs));
    else
        Qpre=Q; 
    end
end





