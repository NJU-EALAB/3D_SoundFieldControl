function [x] = getxPoints(xStart,xStop,N)
x = [];
for n=1: size(xStart,2)
    x1 = [xStart(1,n); xStart(2,n); 0];
    x2 = [xStop(1,n); xStop(2,n); 0];
    x = [x [linspace(x1(1),x2(1),N); linspace(x1(2),x2(2),N); zeros(1,N)]];
end
end
