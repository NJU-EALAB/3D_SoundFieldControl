function plotVenueLSA(fh,x,x0,unitn,dy0,pl)


figure(fh)
plot(x(1,:),x(2,:),'ok','MarkerSize',1.5), hold on

tmp = x(:,end)- x0(:,1);
tmp = tmp/norm(tmp);
plot([x0(1,1) x0(1,1)-tmp(1)*[0:0.1:150]],[x0(2,1) x0(2,1)-tmp(2)*[0:0.1:150]],'Color',[0.95 0.95 1])
plot([x0(1,1) x0(1,1)+tmp(1)*[0:0.1:150]],[x0(2,1) x0(2,1)+tmp(2)*[0:0.1:150]],'Color',[0.95 0.95 1])

tmp = x(:,1)- x0(:,end);
tmp = tmp/norm(tmp);
plot([x0(1,end) x0(1,end)-tmp(1)*[0:0.1:150]],[x0(2,end) x0(2,end)-tmp(2)*[0:0.1:150]],'Color',[0.95 0.95 1])
plot([x0(1,end) x0(1,end)+tmp(1)*[0:0.1:150]],[x0(2,end) x0(2,end)+tmp(2)*[0:0.1:150]],'Color',[0.95 0.95 1])

for n=1:size(x0,2)
    plot([x0(1,n) x0(1,n)+unitn(1,n)*120],[x0(2,n) x0(2,n)+unitn(2,n)*120],'Color',[0.8 0.8 0.8])
    piston(:,n) = cross([0;0;1],unitn(:,n));
    piston(:,n) = piston(:,n)/norm(piston(:,n));
    plot([x0(1,n)-piston(1,n)*dy0/2 x0(1,n)+piston(1,n)*dy0/2], [x0(2,n)-piston(2,n)*dy0/2 x0(2,n)+piston(2,n)*dy0/2],'k','LineWidth',1.5)
end

plot(x(1,:),x(2,:),'ok','MarkerSize',1.5)
plot(x(1,:),x(2,:),'k')
%plot(x0(1,:),x0(2,:),'Color',[0.9 0.9 1])

% for n=[1 size(x0,2)]
%     plot([x0(1,n) x0(1,n)-unitn(1,n)*[0:0.1:100]],[x0(2,n) x0(2,n)-unitn(2,n)*[0:0.1:100]],'Color',[0.5 0.5 0.5])
% end

hold off
xlabel('x / m')
ylabel('y / m')
axis equal
axis([pl.xmin pl.xmax pl.ymin pl.ymax])
set(gca,'XTick',[pl.xmin:pl.dx:pl.xmax])
set(gca,'YTick',[pl.ymin:pl.dy:pl.ymax])
grid on
%title('LSA & Venue Setup')




end

