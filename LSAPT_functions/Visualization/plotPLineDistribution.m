function plotPLineDistribution(fh,P,pl, fL, fH)

cm = cbrewer(pl.CMType, pl.CM, 5);
figure(fh)
plot(P(1,:),'Color',cm(3,:),'LineWidth',0.5), hold on
plot(P(2,:),'Color',cm(4,:),'LineWidth',1)
plot(P(3,:),'Color',cm(5,:),'LineWidth',2)
plot(P(4,:),'Color',cm(4,:),'LineWidth',1)
plot(P(5,:),'Color',cm(3,:),'LineWidth',0.5)
hold off
grid on
axis([0 size(P,2) pl.ymin pl.ymax])

set(gca,'YTick',[pl.ymin:pl.dy:pl.ymax])

xlabel('Venue Position')
ylabel('A / dB_{SPL}')
legend('5%/95%','25%/75%','50%','Location','SouthWest')
title([num2str(fL),'<f/Hz<',num2str(fH/1000),'k'])

end

