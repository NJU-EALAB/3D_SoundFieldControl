function plotDFIP(fh,f,D,Sensitivity,MaxElectricPower,PistonsPerCabinet,p0,Pref,pl)

i = 1:size(D,1);
DFIP = (abs(D) ./ (4*pi * 10^(Sensitivity/20) * 1/sqrt(Pref) * p0)).^2;

figure(fh)
surf(f,i,10*log10(DFIP/Pref)), hold on


for n=[50,60,70,80,90,100,200,300,400,500,600,700,800,900,1000,2000,3000,4000,5000,6000,7000,8000,9000,10000,20000]
    plot3([n n],[i(1)+size(D,1)/18*0.5 i(1)],[300 300],'w','LineWidth',0.5)
    plot3([n n],[length(i) length(i)-size(D,1)/18*0.5],[300 300],'w','LineWidth',0.5)
end
% for n=[-90:15:+90]
%     plot([10 11.5],[n n],'w','LineWidth',0.5)
%     plot([18000 20000],[n n],'k','LineWidth',0.5)
% end

hold off
set(gca,'XScale','log')
set(gca,'Ydir','reverse')
shading flat
view([0 90])
axis([50 20000 1 length(i)])
set(gca,'XTick',[20:10:100 200:100:1000 2000:1000:10000 20000])
set(gca,'XTickLabel',{'20','','','50','','','','','','200','','','','','','','','1k','','','','5k','','','','','','20k'})
set(gca,'YTick',[1:2*PistonsPerCabinet:i(end)])

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

ylabel(hcb,'dB_{rel,1W}')
xlabel('f / Hz')
ylabel('Driver #')
title(['DFIP ',num2str(max(max(10*log10(DFIP/Pref))),'%3.1f'),'dB_{max used}, ', num2str(10*log10(MaxElectricPower),'%3.1f'), 'dB_{max}'])
grid off


end