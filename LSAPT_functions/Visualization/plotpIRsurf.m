function plotpIRsurf(fh,t,pIR,pl)

Pos = 1:size(pIR,2);
pmax = repmat(max(abs(pIR)),size(pIR,1),1);
%pmax = max(max(abs(pIR)));


figure(fh)
imagesc(t*1000,Pos,20*log10(abs(transpose(pIR./pmax))))
%imagesc(t*1000,Pos,20*log10(abs(transpose(pIR/pmax))))
set(gca,'YDir','normal')
shading flat
view([0 90])
N_cm = abs((pl.Max_dB-pl.Min_dB)/pl.Step_dB);
cm = cbrewer(pl.CMType, pl.CM, N_cm);
if pl.CMFlip
    cm = flipud(cm);
end
%hard coded!!!!!
% for n=1:30
%     cm(n,:) = cm(10,:);
% end

%cm(1,:) = [1,1,1];

cm(end,:) = [1,0,0];
cm(end-1,:) = [1,0,0];
cm(end-2,:) = [1,0,0];

colormap(cm)
hcb = colorbar('location','EastOutSide');
set(gca,'CLim',[pl.Min_dB pl.Max_dB])
set(hcb,'YTick',[pl.Min_dB:pl.ddB:pl.Max_dB])
set(hcb,'YTickLabel',[pl.Min_dB:pl.ddB:pl.Max_dB])
ylabel(hcb,'dB')
%title('|p_{IR}(t)|')
axis([pl.xmin pl.xmax Pos(1) Pos(end)])
set(gca,'XTick',[pl.xmin:pl.dx:pl.xmax])
xlabel('t / ms')
ylabel('Venue Position')
end