function [D] = setBrickwallXO(f,D,fXOLM,fXOMH,Flag)
f = repmat(f,size(D,1),1);
if strcmp(Flag,'LF')
    D(f>=fXOLM) = 0;
elseif strcmp(Flag,'MF')
    D(f<fXOLM | f>fXOMH ) = 0;
elseif strcmp(Flag,'HF')
    D(f<=fXOMH) = 0;
else
end
end