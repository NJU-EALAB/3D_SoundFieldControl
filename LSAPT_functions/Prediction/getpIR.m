function [pIR, t] = getpIR(P,fs)
    %***************************************
    %Impulse Response at Evaluation Points
    %***************************************
    P(1,:) = P(1,:)*0;          %no DC
    P(end,:) = abs(P(end,:));   %fs/2 real!
    pIR = ifft([P; flipud(conj(P(2:end-1,:)))]); %temporal IFFT->Matlab Standard!!!
    Nt = size(pIR,1);
    t = [0:Nt-1]/fs;
end