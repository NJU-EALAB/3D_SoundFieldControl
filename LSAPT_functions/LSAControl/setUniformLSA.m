%*******************************************
%get uniformly driven LSA driving functions:
%*******************************************
LSA.LF.D = ones(LSA.N*LSA.LF.M, size(Ac.f,2));
LSA.MF.D = ones(LSA.N*LSA.MF.M, size(Ac.f,2));
LSA.HF.D = ones(LSA.N*LSA.HF.M, size(Ac.f,2));

%*********************
%apply ideal prefilter
%*********************
HPre = getIdealPrefilter(Ac.f,Ac.c);
if LSA.PreFilterFlag
    %do nothing, we already have want we need 
else
    HPre = HPre*0+1;
end
HPre = HPre./max(abs(HPre)); %max 0 dB

LSA.LF.D  = LSA.LF.D .* repmat(transpose(HPre),LSA.N*LSA.LF.M,1);
LSA.MF.D  = LSA.MF.D .* repmat(transpose(HPre),LSA.N*LSA.MF.M,1);
LSA.HF.D  = LSA.HF.D .* repmat(transpose(HPre),LSA.N*LSA.HF.M,1);

%put a point source somewhere out of sight, we don't need it here, but some
%plot functions want to have it:
xPS = [-1000;0;0];
