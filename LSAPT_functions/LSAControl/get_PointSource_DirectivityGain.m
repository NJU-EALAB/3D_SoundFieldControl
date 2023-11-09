function [phi_deg, G_dB] = get_PointSource_DirectivityGain(x0,xPS,phi_PS_FRP_deg,G_PS_FRP_dB)
%[eq. (4.36), Sch16]

phi_deg = zeros(size(x0,2),1); %alloc RAM
G_dB = zeros(size(x0,2),1); %alloc RAM

nx = [1;0;0];
nz = [0;0;1];

for n=1:size(x0,2)
    x0xPS = x0(:,n) - xPS; %get vector between xPS to x0
    norm_x0xPS = x0xPS / norm(x0xPS); %get length of this vector
    phi_deg(n,1) = acos(dot(nx,norm_x0xPS)); %get angle w.r.t. PS 'main lobe', i.e. 0°
    if  dot( nz, cross(norm_x0xPS,nx) ) > 0 %check the sign of the angle
        phi_deg(n,1) = -phi_deg(n,1); 
    end
    phi_deg(n,1) = phi_deg(n,1)*180/pi; %phi in deg
    G_dB(n,1) = spline(phi_PS_FRP_deg,G_PS_FRP_dB,phi_deg(n,1)); %get interpolation
end

end