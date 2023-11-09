function H = getHLSFracInt(f,fL,fH,fs,FilterType)
%[p.177, Sch16], [eq. (4.13), Sch16] 
%we build a half integrator out of low-shelfs
G = +20*log10(sqrt(2));
H = f*0+1;
ftmp = fH;
if strcmp(FilterType,'analog')
    while ftmp>fL
        [b,a,B,A]=lowshelve2ABC(ftmp,fs,G,'B');
        ftmp = ftmp/2;
        H = freqs(B,A,2*pi*f).*H;
    end
elseif strcmp(FilterType,'digital')
    while ftmp>fL
        [b,a,B,A]=lowshelve2ABC(ftmp,fs,G,'B');
        ftmp = ftmp/2;
        H = freqz(b,a,f,fs).*H;
    end
else
end

end

