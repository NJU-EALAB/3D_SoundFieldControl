function [theta, phi] = CalAngle3D(xPS,x)
    xtemp = x - xPS;
    r = vecnorm(xtemp,2);
    theta = atan(-xtemp(2,:)./xtemp(1,:))/pi*180;
    phi = asin(xtemp(3,:)./r)/pi*180;
%     [azi, ele, ~] = cart2sph(xtemp(1,:), xtemp(2,:), xtemp(3,:));
end
