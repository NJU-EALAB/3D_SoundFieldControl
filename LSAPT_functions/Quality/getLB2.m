function [LB2] = getLB2(D,Sensitivity,f,fStart,fStop,Pref,p0)
%[eq. (4.41), Sch16]
LB2_Pre = (abs(D(:,f>fStart & f<fStop)) ./ (4*pi * 10^(Sensitivity/20) * 1/sqrt(Pref) * p0)).^2;
LB2_Pre = 10*log10(LB2_Pre/Pref);
LB2 = quantile(LB2_Pre',[0.05 0.25 0.50 0.75 0.95 1]);
end