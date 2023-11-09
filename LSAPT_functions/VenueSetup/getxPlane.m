function [x,N1,N2] = getxPlane(xP,yP)
    [XP,YP] = meshgrid(xP,yP);
    N1 = size(XP,1);
    N2 = size(XP,2);
    Ng = N1*N2;
    x = [reshape(XP,1,Ng); reshape(YP,1,Ng); zeros(1,Ng)];
end

