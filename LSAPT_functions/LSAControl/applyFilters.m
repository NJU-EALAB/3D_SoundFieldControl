%% LowShelve Correction for Prefilter
HPreShelve = transpose(abs(getHLSFracInt(Ac.f,1,LSA.fPre,Ac.fs,'analog')));
if LSA.PreFilterFlag
    %do nothing, we already have want we need
else
    HPreShelve = HPreShelve*0+1;
end
%% Highpass:
[b,a] = butter(LSA.NHP,2*pi*LSA.fHP,'high','s');
H_HP = transpose(abs(freqs(b,a,2*pi*Ac.f)));
%% Lowpass:
[b,a] = butter(LSA.NLP,2*pi*LSA.fLP,'s');
H_LP = transpose(abs(freqs(b,a,2*pi*Ac.f)));
%% PEQs: not used here at all
[b,a,B,A]=peq2ABC(300,48000,0,0.5,'B');
H_PEQ = transpose(abs(freqs(B,A,2*pi*Ac.f)));
%% series connection of filters
H = HPreShelve.*H_HP.*H_LP.*H_PEQ;
H = H./max(abs(H)); %max 0 dB according to applied max Power
%% apply filters equally to all pistons
LSA.LF.D  = LSA.LF.D .* repmat(transpose(H),LSA.N*LSA.LF.M,1);
LSA.MF.D  = LSA.MF.D .* repmat(transpose(H),LSA.N*LSA.MF.M,1);
LSA.HF.D  = LSA.HF.D .* repmat(transpose(H),LSA.N*LSA.HF.M,1);
%% XO
if 0 %not used anymore
    %********************************
    %apply ideal brickwall crossover:
    %********************************
    LSA.LF.D = setBrickwallXO(Ac.f, LSA.LF.D, LSA.fXOLM, LSA.fXOMH, 'LF');
    LSA.MF.D = setBrickwallXO(Ac.f, LSA.MF.D, LSA.fXOLM, LSA.fXOMH, 'MF');
    LSA.HF.D = setBrickwallXO(Ac.f, LSA.HF.D, LSA.fXOLM, LSA.fXOMH, 'HF');
else
    %***********************************
    %apply zerophase Linkwitz crossover:
    %***********************************
    LSA.LF.D = setLinkwitzRileyXO(Ac.f, LSA.LF.D, LSA.fXOLM, LSA.fXOMH, 'LF');
    LSA.MF.D = setLinkwitzRileyXO(Ac.f, LSA.MF.D, LSA.fXOLM, LSA.fXOMH, 'MF');
    LSA.HF.D = setLinkwitzRileyXO(Ac.f, LSA.HF.D, LSA.fXOLM, LSA.fXOMH, 'HF');
end
