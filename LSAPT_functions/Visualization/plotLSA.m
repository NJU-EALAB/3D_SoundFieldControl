function plotLSA(fh,x0,unitn,dy0)
figure(fh)
%plot(x0(1,:),x0(2,:),'o','Color',[0.8 0.8 0.8],'MarkerSize',1), hold on
plot(x0(1,:),x0(2,:),'Color',[0.9 0.9 1]), hold on
for n=1:size(x0,2)
    plot([x0(1,n) x0(1,n)+unitn(1,n)*110],[x0(2,n) x0(2,n)+unitn(2,n)*110],'Color',[0.5 0.5 0.5])
    piston(:,n) = cross([0;0;1],unitn(:,n));
    piston(:,n) = piston(:,n)/norm(piston(:,n));
    plot([x0(1,n)-piston(1,n)*dy0/2 x0(1,n)+piston(1,n)*dy0/2], [x0(2,n)-piston(2,n)*dy0/2 x0(2,n)+piston(2,n)*dy0/2],'k','LineWidth',2)
end
hold off
xlabel('x / m')
ylabel('y / m')
axis equal
%axis([-5 40 -10 20])
grid on
title('LSA Setup')
end

