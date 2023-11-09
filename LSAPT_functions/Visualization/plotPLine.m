function plotPLine(fh,f,P,p0,pl)
cm = flipud(cbrewer(pl.CMType, pl.CM, ceil(1.5*size(P,2))));
if pl.CMFlip
    cm = flipud(cm);
end

figure(fh)
for n=1:size(P,2)
    semilogx(f,20*log10(abs(P(:,n)/p0)),'Color',cm(n,:)), hold on
end
hold off
axis([50 20000 pl.ymin pl.ymax])
set(gca,'XTick',[20:10:100 200:100:1000 2000:1000:10000 20000])
set(gca,'XTickLabel',{'20','','','50','','','','','','200','','','500','','','','','1k','2k','','','5k','','','','','10k',''})
set(gca,'YTick',[pl.ymin:pl.dy:pl.ymax])
grid on
xlabel('f / Hz')
ylabel('A / dB_{SPL}')

end