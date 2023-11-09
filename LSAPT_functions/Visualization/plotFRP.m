function plotFRP(fh,f,phi,P,p0,rFar,pl)
figure(fh)
surf(f,phi*180/pi,20*log10(abs(P/p0))+20*log10(rFar/16)), hold on

for n=[10,20,30,40,50,60,70,80,90,100,200,300,400,500,600,700,800,900,1000,2000,3000,4000,5000,6000,7000,8000,9000,10000,20000]
    plot3([n n],[-75 -70],[300 300],'w','LineWidth',0.5)
    plot3([n n],[70 75],[300 300],'w','LineWidth',0.5)
end

for n=[-90:15:+90]
    plot3([50 55],[n n],[300 300],'w','LineWidth',0.5)
    plot3([18000 20000],[n n],[300 300],'k','LineWidth',0.5)
end

hold off
set(gca,'XScale','Log')
shading flat
view([0 90])

axis([50 20000 pl.ymin pl.ymax])
set(gca,'XTick',[20:10:100 200:100:1000 2000:1000:10000 20000])
set(gca,'XTickLabel',{'20','','','50','','','','','','200','','','','','','','','1k','','','','5k','','','','','','20k'})

set(gca,'YTick',[pl.ymin:pl.dy:pl.ymax])
set(gca,'YTickLabel',[pl.ymin:pl.dy:pl.ymax])

xlabel('f / Hz')
ylabel('\phi / deg')
title('FRP in dB_{rel,16m}')


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

end