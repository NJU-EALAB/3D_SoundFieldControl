function [fLB1, LB1] = getLB1(D,Sensitivity,f,fStart,fStop,Pref,p0)
%[eq. (4.40), Sch16]
fLB1 = f(f>fStart & f<fStop);
LB1_Pre = (abs(D(:,f>fStart & f<fStop)) ./ (4*pi * 10^(Sensitivity/20) * 1/sqrt(Pref) * p0)).^2;
LB1_Pre = 10*log10(LB1_Pre/Pref);
LB1 = quantile(LB1_Pre,[0.05 0.25 0.50 0.75 0.95 1]);
end

