function plotPIP(fh,f,P,p0,pl)

Pos = 1:size(P,2);
figure(fh)
surf(f,Pos,20*log10(abs(transpose(P)/p0))), hold on

for n=[50,60,70,80,90,100,200,300,400,500,600,700,800,900,1000,2000,3000,4000,5000,6000,7000,8000,9000,10000,20000]
    plot3([n n],[Pos(1)+size(P,2)/30*0.5 Pos(1)],[300 300],'k','LineWidth',0.5)
    plot3([n n],[length(Pos) length(Pos)-size(P,2)/30*0.5],[300 300],'k','LineWidth',0.5)
end

hold off
set(gca,'XScale','log')
shading flat
view([0 90])
axis([50 20000 1 length(Pos)])
set(gca,'XTick',[20:10:100 200:100:1000 2000:1000:10000 20000])
set(gca,'XTickLabel',{'20','','','50','','','','','','200','','','','','','','','1k','','','','5k','','','','','','20k'})

N_cm = abs((pl.Max_dB-pl.Min_dB)/pl.Step_dB);
cm = cbrewer(pl.CMType, pl.CM, N_cm);
if pl.CMFlip
    cm = flipud(cm);
end
colormap(cm)
hcb = colorbar('location','EastOutSide');
set(gca,'CLim',[pl.Min_dB pl.Max_dB])
set(hcb,'YTick',[pl.Min_dB:pl.ddB:pl.Max_dB])
set(hcb,'YTickLabel',[pl.Min_dB:pl.ddB:pl.Max_dB])

ylabel(hcb,'A / dB_{SPL}')
xlabel('f / Hz')
ylabel('Venue Position')
title(['PIP'])
grid off
end