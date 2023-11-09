function Gain = getDrivingFunctionGain(Sensitivity, ElectricPower, p0, Pref)
% [eq. 4.28, Sch16]
Gain = 4*pi * 10^(Sensitivity/20) * sqrt(ElectricPower)/sqrt(Pref) * p0;
end

