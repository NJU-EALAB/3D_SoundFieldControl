function checkSingleCabinet(fhFreqResp,fhFRP,LSA,Ac,plLine,plFRP,FRPFlag)

LSA.splay_deg = 0;
LSA.xT = [0;LSA.dy0/2;0];
LSA.PreFilterFlag = 0;
LSA = setLSA(LSA,Ac);

%*******************************************
%get uniformly driven LSA driving functions:
%*******************************************
LSA.LF.D = ones(LSA.N*LSA.LF.M, size(Ac.f,2));
LSA.MF.D = ones(LSA.N*LSA.MF.M, size(Ac.f,2));
LSA.HF.D = ones(LSA.N*LSA.HF.M, size(Ac.f,2));

%********************************
%apply ideal brickwall crossover:
%********************************
%LSA.LF.D = setBrickwallXO(Ac.f, LSA.LF.D, LSA.fXOLM, LSA.fXOMH, 'LF');
%LSA.MF.D = setBrickwallXO(Ac.f, LSA.MF.D, LSA.fXOLM, LSA.fXOMH, 'MF');
%LSA.HF.D = setBrickwallXO(Ac.f, LSA.HF.D, LSA.fXOLM, LSA.fXOMH, 'HF');

%***********************************
%apply zerophase Linkwitz crossover:
%***********************************
LSA.LF.D = setLinkwitzRileyXO(Ac.f, LSA.LF.D, LSA.fXOLM, LSA.fXOMH, 'LF');
LSA.MF.D = setLinkwitzRileyXO(Ac.f, LSA.MF.D, LSA.fXOLM, LSA.fXOMH, 'MF');
LSA.HF.D = setLinkwitzRileyXO(Ac.f, LSA.HF.D, LSA.fXOLM, LSA.fXOMH, 'HF');

if 0 %plot for check
figure(fhFreqResp)
semilogx(Ac.f,20*log10(abs(LSA.LF.D)),'r'), hold on
semilogx(Ac.f,20*log10(abs(LSA.MF.D)),'g')
semilogx(Ac.f,20*log10(abs(LSA.HF.D)),'b')
hold off
axis([20 20000 -100 0])
set(gca,'XTick',[20:10:100 200:100:1000 2000:1000:10000 20000])
set(gca,'XTickLabel',{'20','','','50','','','','','100','200','','','500','','','','','1k','2k','','','5k','','','','','10k','20k'})
set(gca,'YTick',[-100:20:0])
grid on
xlabel('f / Hz')
ylabel('A / dB_{SPL}')
end

%get it to 120dB @ 1m with predefined Gains:
LSA.LF.D = LSA.LF.D * LSA.LF.Gain;
LSA.MF.D = LSA.MF.D * LSA.MF.Gain;
LSA.HF.D = LSA.HF.D * LSA.HF.Gain;

%On-Axis:
Venue.Line.x = repmat(LSA.LF.x0,1,5);
Venue.Line.x(1,1) = 1;
Venue.Line.x(1,2) = 2;
Venue.Line.x(1,3) = 4;
Venue.Line.x(1,4) = 8;
Venue.Line.x(1,5) = 16;

[Pred.Line.LF.r, Pred.Line.LF.beta]     = getPreATF_Fast(Venue.Line.x, LSA.LF.x0, LSA.LF.unitn);
[Pred.Line.MF.r, Pred.Line.MF.beta]     = getPreATF_Fast(Venue.Line.x, LSA.MF.x0, LSA.MF.unitn);
[Pred.Line.HF.r, Pred.Line.HF.beta]     = getPreATF_Fast(Venue.Line.x, LSA.HF.x0, LSA.HF.unitn);

PLine = getPLine(Pred.Line, LSA, Ac.c, Ac.f);
for n=1:size(Venue.Line.x,2)
    PLine(:,n) = PLine(:,n)*2^(n-1);
end
plotPLine(fhFreqResp,Ac.f,PLine,Ac.p0,plLine);
%legend('1m','2m','4m','8m','16m','Location','SouthWest')
title('Single Cabinet rel. 1m')
if FRPFlag
%FRP:
Venue.FRP.xM = [0;0;0];
Venue.FRP.rFar = 2^14;
Venue.FRP.dphi_deg = 0.5;
[Venue.FRP.x, Venue.FRP.phi] = getxFRP(Venue.FRP.xM,Venue.FRP.rFar,Venue.FRP.dphi_deg);

[Pred.FRP.LF.r, Pred.FRP.LF.beta]       = getPreATF_Fast(Venue.FRP.x, LSA.LF.x0, LSA.LF.unitn);
[Pred.FRP.MF.r, Pred.FRP.MF.beta]       = getPreATF_Fast(Venue.FRP.x, LSA.MF.x0, LSA.MF.unitn);
[Pred.FRP.HF.r, Pred.FRP.HF.beta]       = getPreATF_Fast(Venue.FRP.x, LSA.HF.x0, LSA.HF.unitn);

PFRP = getPFRP(Pred.FRP, LSA, Ac.c, Ac.f);

plotFRP(fhFRP, Ac.f, Venue.FRP.phi, PFRP,Ac.p0, Venue.FRP.rFar, plFRP)

end









end

