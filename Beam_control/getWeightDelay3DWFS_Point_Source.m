function [Weight, Delay] = getWeightDelay3DWFS_Point_Source(x0, unitn, xPS, c)
Delay = vecnorm(x0 - xPS,2)/c;
Delay = Delay - min(Delay);
Weight = sum((x0 - xPS).*unitn)./(vecnorm(x0-xPS).^2);
end
