%**************************************************************************
%[Sch13] Schultz, F. et. al (2013): "Derivation of IIR prefilters for soundfield
%synthesis using linear secondary source distributions." In: Proc. of AIA-DAGA 2013 
%Conference on Acoustics 2013, Merano, 2372-2375.
%**************************************************************************
%see test script Prefilter_sqrt_iw_as_Shelve_Lagrange.m 
%for derivation of lagrange interpolation and parameters

%f,H -> [1xNFFT]-vectors

%Achtung: die Parametrisierung für Bandwidth_in_Oct, Offset_dB funktioniert
%derzeit nur für sqrt(1i*w/c)-Filter, bei anderen Flanken ist die
%Parametrisierung für die Lagrange-Interpolation uU nicht geeignet

function [H] = getShelveLagrange(f,H,FlagSub,fSub,FlagAliasing,fAliasing,Bandwidth_in_Oct)

    

    Hphase = unwrap(angle(H)); %save original phase
    H = 20*log10(abs(H)); %Interpolation in dB
    
    if Bandwidth_in_Oct==4
        Offset_dB = 1.5053;
    elseif Bandwidth_in_Oct==3
        Offset_dB = 1.1286;
    elseif Bandwidth_in_Oct==2
        Offset_dB = 0.7528;
    elseif Bandwidth_in_Oct==1
        Offset_dB = 0.3766;
    elseif Bandwidth_in_Oct==0.5
        Offset_dB = 0.1857;    
    else
        disp('error, Bandwidth_in_Oct must be 1,2,3 or 4')
    end
    
    if FlagSub
        %Sub-Bass Limitierung:
        tmp=(find(f<=fSub)); fSub_i = tmp(end); 
        H_Sub = H*0+H(fSub_i);
        H_Sub(1) = H_Sub(2);
    end

    if FlagAliasing
        %Aliasing-Frequenz Limitierung:
        tmp=(find(f<=fAliasing)); falias_i = tmp(end);
        H_Alias = H*0+H(falias_i);
        H_Alias(1) = H_Alias(2);
    end
    
    if FlagSub
        %Lagrange-Interpolation für SUB:
        fl = f(fSub_i)*2^(-Bandwidth_in_Oct/2);
        fh = f(fSub_i)*2^(+Bandwidth_in_Oct/2);
        tmp=(find(f<=fl)); fl_i = tmp(end); 
        tmp=(find(f<=fh)); fh_i = tmp(end); 

        P1x = log10(f(fl_i));
        P1y = H_Sub(fl_i);
        P2x = log10(f(fSub_i));
        P2y = H_Sub(fSub_i)+Offset_dB;
        P3x = log10(f(fh_i));
        P3y = H(fh_i);

        %Lagrange Interpolation tmp variables:
        ipol1=P1y/((P1x-P2x)*(P1x-P3x));
        ipol2=P2y/((P2x-P1x)*(P2x-P3x));
        ipol3=P3y/((P3x-P1x)*(P3x-P2x));

        for fi=1:fl_i-1
        H(fi) = H_Sub(fi);
        end
        
        for fi=fl_i:fh_i
            H(fi)=          (ipol1*(log10(f(fi))-P2x)*(log10(f(fi))-P3x))+...
                            (ipol2*(log10(f(fi))-P1x)*(log10(f(fi))-P3x))+...
                            (ipol3*(log10(f(fi))-P1x)*(log10(f(fi))-P2x));       
        end
    end
    
    if FlagAliasing
        %Lagrange-Interpolation für ALIASING:
        fl = f(falias_i)*2^(-Bandwidth_in_Oct/2);
        fh = f(falias_i)*2^(+Bandwidth_in_Oct/2);
        tmp=(find(f<=fl)); fl_i = tmp(end); 
        tmp=(find(f<=fh)); fh_i = tmp(end);

        P1x = log10(f(fl_i));
        P1y = H(fl_i);
        P2x = log10(f(falias_i));
        P2y = H_Alias(falias_i)-Offset_dB;
        P3x = log10(f(fh_i));
        P3y = H_Alias(fh_i);

        %Lagrange Interpolation tmp var:
        ipol1=P1y/((P1x-P2x)*(P1x-P3x));
        ipol2=P2y/((P2x-P1x)*(P2x-P3x));
        ipol3=P3y/((P3x-P1x)*(P3x-P2x));

        for fi=fl_i:fh_i
            H(fi)=      (ipol1*(log10(f(fi))-P2x)*(log10(f(fi))-P3x))+...
                        (ipol2*(log10(f(fi))-P1x)*(log10(f(fi))-P3x))+...
                        (ipol3*(log10(f(fi))-P1x)*(log10(f(fi))-P2x));
        end

        for fi=fh_i+1:length(H)
            H(fi) = H_Alias(fi);
        end       
    end
   
    %apply original phase and delog
    H = 10.^(H/20).*exp(1i*Hphase);
    H(1) = abs(H(2));
end
