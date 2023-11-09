function plotpIR(fh,t,pIR,pl)

%cm = flipud(cbrewer(pl.CMType, pl.CM, ceil(1.5*size(pIR,2))));
%cm = flipud(gray(ceil(1.25*size(pIR,2))));
cm = (cbrewer('seq', 'PuBu', ceil(1.5*size(pIR,2))));
if pl.CMFlip
    cm = flipud(cm);
end

figure(fh)

pMax = max(max(abs(pIR)));

for n=1:size(pIR,2)
    plot(t*1000,20*log10(abs(pIR(:,n)/pMax)),'Color',cm(n,:)), hold on
end
hold off
axis([pl.xmin pl.xmax pl.ymin pl.ymax])
set(gca,'XTick',[pl.xmin:pl.dx:pl.xmax])
set(gca,'YTick',[pl.ymin:pl.dy:pl.ymax])

grid on
xlabel('t / ms')
ylabel('dB_{rel,1stIR}')
end