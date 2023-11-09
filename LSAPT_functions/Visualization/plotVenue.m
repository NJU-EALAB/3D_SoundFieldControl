function plotVenue(fh,x)
figure(fh)
plot(x(1,:),x(2,:),'ok'), hold on
plot(x(1,:),x(2,:),'k'), hold off
axis equal
xlabel('x / m')
ylabel('y / m')
title('Venue Setup')
end

