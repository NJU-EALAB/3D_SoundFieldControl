function [D] = setLinkwitzRileyXO(f,D,fXOLM,fXOMH,Flag)
%Linkwitz, S. H. Active Crossover Networks for Noncoincident Drivers
%J. Audio Eng. Soc., 1976, 24, 2-8
NButter = 10; %=2*10*6dB/oct. -> 120dB/oct.
if strcmp(Flag,'LF')
    [B,A] = butter(NButter,2*pi*fXOLM,'s');
    HLP = freqs(B,A,2*pi*f);
    HLP = abs(HLP.*HLP);
    D = D.*repmat(HLP,size(D,1),1);
elseif strcmp(Flag,'MF')
    [B,A] = butter(NButter,2*pi*fXOLM,'high','s');
    HHP = freqs(B,A,2*pi*f);
    [B,A] = butter(NButter,2*pi*fXOMH,'s');
    HLP = freqs(B,A,2*pi*f);

    H = abs(HHP.*HHP.*HLP.*HLP);
    D = D.*repmat(H,size(D,1),1);    
elseif strcmp(Flag,'HF')
    [B,A] = butter(NButter,2*pi*fXOMH,'high','s');
    HHP = freqs(B,A,2*pi*f);
    HHP = abs(HHP.*HHP);
    D = D.*repmat(HHP,size(D,1),1); 
else
end
end

