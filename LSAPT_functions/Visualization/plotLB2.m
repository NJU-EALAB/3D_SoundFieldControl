function plotLB2(fh,LB2_LF,LB2_MF,LB2_HF,PistonsPerCabinetLF,PistonsPerCabinetMF,PistonsPerCabinetHF,pl)

cm = cbrewer(pl.CMType, pl.CM, 6);

figure(fh)
subplot(1,3,1)
pistonNr = [1:size(LB2_LF,2)];
plot(pistonNr,LB2_LF(6,:),'Color',cm(6,:),'LineWidth',1), hold on
plot(pistonNr,LB2_LF(1,:),'Color',cm(3,:),'LineWidth',0.5)
plot(pistonNr,LB2_LF(2,:),'Color',cm(4,:),'LineWidth',1)
plot(pistonNr,LB2_LF(3,:),'Color',cm(5,:),'LineWidth',1)
plot(pistonNr,LB2_LF(4,:),'Color',cm(4,:),'LineWidth',1)
plot(pistonNr,LB2_LF(5,:),'Color',cm(3,:),'LineWidth',0.5)

hold off
axis([1 pistonNr(end) -15 25 ])
set(gca,'YTick',[-40:10:30])
set(gca,'XTick',[1:2*PistonsPerCabinetLF:pistonNr(end)])
ylabel('dB_{rel,1W}')
xlabel('Driver #')
title('LB2 LF')
grid on
view([90 90])

subplot(1,3,2)
pistonNr = [1:size(LB2_MF,2)];
plot(pistonNr,LB2_MF(6,:),'Color',cm(6,:),'LineWidth',1), hold on
plot(pistonNr,LB2_MF(1,:),'Color',cm(3,:),'LineWidth',0.5)
plot(pistonNr,LB2_MF(2,:),'Color',cm(4,:),'LineWidth',1)
plot(pistonNr,LB2_MF(3,:),'Color',cm(5,:),'LineWidth',1)
plot(pistonNr,LB2_MF(4,:),'Color',cm(4,:),'LineWidth',1)
plot(pistonNr,LB2_MF(5,:),'Color',cm(3,:),'LineWidth',0.5)

hold off
axis([1 pistonNr(end) -15 25 ])
set(gca,'YTick',[-40:10:30])
set(gca,'XTick',[1:2*PistonsPerCabinetMF:pistonNr(end)])
ylabel('dB_{rel,1W}')
%xlabel('Driver # MF')
title('LB2 MF')
grid on
view([90 90])

subplot(1,3,3)
pistonNr = [1:size(LB2_HF,2)];
plot(pistonNr,LB2_HF(6,:),'Color',cm(6,:),'LineWidth',1), hold on
plot(pistonNr,LB2_HF(1,:),'Color',cm(3,:),'LineWidth',0.5)
plot(pistonNr,LB2_HF(2,:),'Color',cm(4,:),'LineWidth',1)
plot(pistonNr,LB2_HF(3,:),'Color',cm(5,:),'LineWidth',1)
plot(pistonNr,LB2_HF(4,:),'Color',cm(4,:),'LineWidth',1)
plot(pistonNr,LB2_HF(5,:),'Color',cm(3,:),'LineWidth',0.5)

hold off
axis([1 pistonNr(end) -15 25 ])
set(gca,'YTick',[-40:10:30])
set(gca,'XTick',[1:2*PistonsPerCabinetHF:pistonNr(end)])
ylabel('dB_{rel,1W}')
%xlabel('Driver # HF')
title('LB2 HF')
grid on
legend('100%','5%/95%','25%/75%','50%','Location','SouthEast')

view([90 90])

end