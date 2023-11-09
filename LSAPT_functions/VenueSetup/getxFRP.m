function [x, phi] = getxFRP(xM,r,dphi_deg)
%xM position vector of FRP origin
%r radius in m where FRP is to be eval
%dphi_deg FPR resolution equidistant angle in deg
phi = -pi/2:dphi_deg*pi/180:+pi/2;
[x,y,z] = sph2cartFS(pi/2,phi,r);
x = [x; y; x*0];
x = x + repmat(xM,1,size(x,2));
end