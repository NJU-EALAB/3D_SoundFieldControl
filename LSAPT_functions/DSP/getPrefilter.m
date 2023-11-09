%WFS-Prefilter with
%**************************************************************************
%[Sch13] Schultz, F. et. al (2013): "Derivation of IIR prefilters for soundfield
%synthesis using linear secondary source distributions." In: Proc. of AIA-DAGA 2013 
%Conference on Acoustics 2013, Merano, 2372-2375.
%**************************************************************************
function [HPre] = getPrefilter(fsub,Bandwidth_in_Oct,fPre)
H_Pre3dB = 10*log10(fPre);
HPre = getShelveLagrange(fPre,10.^(H_Pre3dB/20),1,fsub,0,0,Bandwidth_in_Oct);
HPre = HPre/HPre(find(fPre<=20,1,'last'));
HPre = transpose(HPre)*sqrt(1i);
end

