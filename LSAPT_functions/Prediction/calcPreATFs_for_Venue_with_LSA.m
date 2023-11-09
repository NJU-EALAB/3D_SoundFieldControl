%******************************
%PreATF->frequency independent!
%only Calc
%******************************
if SimRes.CalcPreATF
    if SimRes.PlaneFlag
        tic
        [Pred.Plane.LF.r, Pred.Plane.LF.beta]   = getPreATF_Fast(Venue.Plane.x, LSA.LF.x0, LSA.LF.unitn);
        [Pred.Plane.MF.r, Pred.Plane.MF.beta]   = getPreATF_Fast(Venue.Plane.x, LSA.MF.x0, LSA.MF.unitn);
        [Pred.Plane.HF.r, Pred.Plane.HF.beta]   = getPreATF_Fast(Venue.Plane.x, LSA.HF.x0, LSA.HF.unitn);
        disp('PreATF Plane:')
        toc
    end
    if SimRes.AudFlag
        tic
        [Pred.Aud.LF.r, Pred.Aud.LF.beta]       = getPreATF_Fast(Venue.Aud.x, LSA.LF.x0, LSA.LF.unitn);
        [Pred.Aud.MF.r, Pred.Aud.MF.beta]       = getPreATF_Fast(Venue.Aud.x, LSA.MF.x0, LSA.MF.unitn);
        [Pred.Aud.HF.r, Pred.Aud.HF.beta]       = getPreATF_Fast(Venue.Aud.x, LSA.HF.x0, LSA.HF.unitn);
        disp('PreATF Aud:')
        toc
    end
    if SimRes.AvoidFlag
        tic
        [Pred.Avoid.LF.r, Pred.Avoid.LF.beta]       = getPreATF_Fast(Venue.Avoid.x, LSA.LF.x0, LSA.LF.unitn);
        [Pred.Avoid.MF.r, Pred.Avoid.MF.beta]       = getPreATF_Fast(Venue.Avoid.x, LSA.MF.x0, LSA.MF.unitn);
        [Pred.Avoid.HF.r, Pred.Avoid.HF.beta]       = getPreATF_Fast(Venue.Avoid.x, LSA.HF.x0, LSA.HF.unitn);
        disp('PreATF Avoid:')
        toc
    end    
    if SimRes.FRPFlag
        tic
        [Pred.FRP.LF.r, Pred.FRP.LF.beta]       = getPreATF_Fast(Venue.FRP.x, LSA.LF.x0, LSA.LF.unitn);
        [Pred.FRP.MF.r, Pred.FRP.MF.beta]       = getPreATF_Fast(Venue.FRP.x, LSA.MF.x0, LSA.MF.unitn);
        [Pred.FRP.HF.r, Pred.FRP.HF.beta]       = getPreATF_Fast(Venue.FRP.x, LSA.HF.x0, LSA.HF.unitn);
        disp('PreATF FRP:')
        toc
    end
    save('PreATF','Pred')
else
    load('PreATF')
end