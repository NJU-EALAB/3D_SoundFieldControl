function [P, feval] = getPPlane(PreATF, LSA, N1, N2, c, f, fdes)
for n=1:length(fdes)
    fi = find(f<=fdes(n),1,'last');
    feval(n) = f(fi);
    
    w_c = 2*pi*f(fi)/c;
    
    ATF = getATF(PreATF.LF.r,  PreATF.LF.beta, w_c, LSA.LF.PistonModel, LSA.LF.PistonDimension);
    D = LSA.LF.D(:,fi);
    PLF = reshape(ATF*D,N1,N2);
    
    ATF = getATF(PreATF.MF.r,  PreATF.MF.beta, w_c, LSA.MF.PistonModel, LSA.MF.PistonDimension);
    D = LSA.MF.D(:,fi);
    PMF = reshape(ATF*D,N1,N2);
    
    ATF = getATF(PreATF.HF.r,  PreATF.HF.beta, w_c, LSA.HF.PistonModel, LSA.HF.PistonDimension);
    D = LSA.HF.D(:,fi);
    PHF = reshape(ATF*D,N1,N2);
    
%     P(:,:,n) = PLF + PMF + PHF;
    P(:,:,n) =PMF;
end
end

