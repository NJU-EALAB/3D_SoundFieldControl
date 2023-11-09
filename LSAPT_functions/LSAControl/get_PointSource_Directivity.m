function [phi_deg, G_dB, DistRatio] = get_PointSource_Directivity(x,xPS,xRef,dBmin,dBDD)
% [eq. (4.34), (4.35), Sch16]

%x: [3xM] audience positions
%xPS: [3x1] point source position
%xRef: [3x1] reference point position at which point source FRP should be
%0dB
%dBmin: dB value relative to maximum FRP Gain to which the FRP at -90°/+90°
%should be attenuated
%dBDD: dB distance doubling factor, -20 means SPL is equal at all audience
%points
%-10 means a 3dB level loss per distance doubling
%0 means point source with equal amplitudes over angle

%return:
%phi_deg FRP angles
%G_dB FRP values in dB
%DistRatio ratio between xRef<->xPS and all other audience points

phi_deg = zeros(size(x,2),1); %alloc RAM
%G_dB = zeros(size(x,2),1); %alloc RAM
norm_xxPS = zeros(size(x,2),1); %alloc RAM;

nx = [1;0;0];
nz = [0;0;1];

for n=1:size(x,2)
    xxPS = x(:,n) - xPS; %get vector between audience point and point source
    norm_xxPS(n,1) = norm(xxPS); %vector length
    unit_xxPS = xxPS/norm_xxPS(n,1); %get unit vector

    phi_deg(n,1) = acos(dot(unit_xxPS,nx)); %get the angle between x-axis and the derived unit vec by dot product
    if (dot(nz, cross(unit_xxPS, nx)) > 0) %check if the angle must be negated
        phi_deg(n,1) = -phi_deg(n,1);
    end
    phi_deg(n,1) = phi_deg(n,1) *180/pi; %get angle in deg
end
G_dB = dBDD*log10(norm(xPS-xRef)./norm_xxPS); %

%% build -90° to +90° for good cubic spline interpolation:
phi_tilt_down = (-90:1:floor(phi_deg(1)))';
phi_tilt_up = (ceil(phi_deg(end)):1:90)';
maxG = max(G_dB);
G_tilt_down = (linspace(dBmin+maxG,G_dB(1),length(phi_tilt_down)))';
G_tilt_up = (linspace(G_dB(end),dBmin+maxG,length(phi_tilt_up)))';

phi_deg = [phi_tilt_down; phi_deg; phi_tilt_up];
G_dB = [G_tilt_down; G_dB; G_tilt_up];

%%
DistRatio = norm_xxPS./norm(xPS-xRef);

end