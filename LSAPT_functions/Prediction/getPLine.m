function P = getPLine(PreATF, LSA, c, f)

for n=1:length(f)
    w_c = 2*pi*f(n)/c;
    
    ATF = getATF(PreATF.LF.r,  PreATF.LF.beta, w_c, LSA.LF.PistonModel, LSA.LF.PistonDimension);
    D = LSA.LF.D(:,n);
    PLF = ATF*D;
    
    ATF = getATF(PreATF.MF.r,  PreATF.MF.beta, w_c, LSA.MF.PistonModel, LSA.MF.PistonDimension);
    D = LSA.MF.D(:,n);
    PMF = ATF*D;
    
    ATF = getATF(PreATF.HF.r,  PreATF.HF.beta, w_c, LSA.HF.PistonModel, LSA.HF.PistonDimension);
    D = LSA.HF.D(:,n);
    PHF = ATF*D;
    
    P(n,:) = transpose(PLF + PMF + PHF);
end

end