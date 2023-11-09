function plotLB1(fh,fLB1_LF,LB1_LF,...
    fLB1_MF,LB1_MF,...
    fLB1_HF,LB1_HF,...
PmaxLF,PmaxMF,PmaxHF,...
    Pref,pl)

cm = cbrewer(pl.CMType, pl.CM, 6);

figure(fh)
semilogx(fLB1_LF,fLB1_LF*0+10*log10(PmaxLF/Pref),'Color',[0.5 0.5 0.5],'LineWidth',1.5), hold on
semilogx(fLB1_MF,fLB1_MF*0+10*log10(PmaxMF/Pref),'Color',[0.5 0.5 0.5],'LineWidth',1.5)
semilogx(fLB1_HF,fLB1_HF*0+10*log10(PmaxHF/Pref),'Color',[0.5 0.5 0.5],'LineWidth',1.5)

semilogx(fLB1_LF,LB1_LF(1,:),'Color',cm(3,:),'LineWidth',0.5)
semilogx(fLB1_LF,LB1_LF(2,:),'Color',cm(4,:),'LineWidth',1)
semilogx(fLB1_LF,LB1_LF(3,:),'Color',cm(5,:),'LineWidth',1)
semilogx(fLB1_LF,LB1_LF(4,:),'Color',cm(4,:),'LineWidth',1)
semilogx(fLB1_LF,LB1_LF(5,:),'Color',cm(3,:),'LineWidth',0.5)
semilogx(fLB1_LF,LB1_LF(6,:),'Color',cm(6,:),'LineWidth',1)


semilogx(fLB1_MF,LB1_MF(1,:),'Color',cm(3,:),'LineWidth',0.5)
semilogx(fLB1_MF,LB1_MF(2,:),'Color',cm(4,:),'LineWidth',1)
semilogx(fLB1_MF,LB1_MF(3,:),'Color',cm(5,:),'LineWidth',1)
semilogx(fLB1_MF,LB1_MF(4,:),'Color',cm(4,:),'LineWidth',1)
semilogx(fLB1_MF,LB1_MF(5,:),'Color',cm(3,:),'LineWidth',0.5)
semilogx(fLB1_MF,LB1_MF(6,:),'Color',cm(6,:),'LineWidth',1)


semilogx(fLB1_HF,LB1_HF(1,:),'Color',cm(3,:),'LineWidth',0.5)
semilogx(fLB1_HF,LB1_HF(2,:),'Color',cm(4,:),'LineWidth',1)
semilogx(fLB1_HF,LB1_HF(3,:),'Color',cm(5,:),'LineWidth',1)
semilogx(fLB1_HF,LB1_HF(4,:),'Color',cm(4,:),'LineWidth',1)
semilogx(fLB1_HF,LB1_HF(5,:),'Color',cm(3,:),'LineWidth',0.5)
semilogx(fLB1_HF,LB1_HF(6,:),'Color',cm(6,:),'LineWidth',1)


hold off
grid on
axis([50 20000 -20 +35])
set(gca,'XTick',[20:10:100 200:100:1000 2000:1000:10000 20000])
set(gca,'XTickLabel',{'20','','','50','','','','','','200','','','500','','','','','1k','2k','','','5k','','','','','10k',''})
set(gca,'YTick',[-40:10:+30])
xlabel('f / Hz')
ylabel('dB_{rel,1W}')
%title('LB1 5,25,50,75,95,100% quantiles')
title('LB1')
end