function [x0,unitn] = getArcArray(L,N,phiArc_deg)
%[Ch. 4.1, Sch16]
if phiArc_deg==0
    phiArc_deg = 1e-16;
end
phiArc = phiArc_deg *pi/180;
rSSD = L/phiArc; %get distance that belongs to origin of the circle that includes the desired arc
xPS = [-rSSD;0;0];  %arc center position
%SSD positions:
x0 = [cos(-phiArc/2:phiArc/(N-1):+phiArc/2)*rSSD;
    sin(-phiArc/2:phiArc/(N-1):+phiArc/2)*rSSD;
    cos(-phiArc/2:phiArc/(N-1):+phiArc/2)*rSSD*0];
x0(1,:) = x0(1,:)-rSSD;
%SSD unit vectors:
unitn = x0*0;
for n=1:size(x0,2)
    tmp = x0(:,n)-xPS;
    unitn(:,n) = tmp/norm(tmp);
end
end

