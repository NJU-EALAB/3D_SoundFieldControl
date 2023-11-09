function [DLF, DMF, DHF] = setDrivingFunctionMaxPower(DLF, DMF, DHF, gLF, gMF, gHF, SensLF, SensMF, SensHF, PowerLF, PowerMF, PowerHF, p0, Pref)

%first compensate for the sensitivity differences using the 120dB@16m reference gains: 
DLF = DLF * gLF;
DMF = DMF * gMF;
DHF = DHF * gHF;

%the calculate the applied powers:
DLFtmp = max(max((abs(DLF) ./ (4*pi * 10^(SensLF/20) * 1/sqrt(Pref) * p0)).^2));
DMFtmp = max(max((abs(DMF) ./ (4*pi * 10^(SensMF/20) * 1/sqrt(Pref) * p0)).^2));
DHFtmp = max(max((abs(DHF) ./ (4*pi * 10^(SensHF/20) * 1/sqrt(Pref) * p0)).^2));

%get the min of (Max Power - desired Power)
tmp = min([...
    10*log10(PowerLF/Pref) - 10*log10(DLFtmp/Pref)...
    10*log10(PowerMF/Pref) - 10*log10(DMFtmp/Pref)...
    10*log10(PowerHF/Pref) - 10*log10(DHFtmp/Pref)]);
%this min has to be compensated making one driver driven with Max Power
tmp = 10^(tmp/20);

%apply this Max Power:
DLF = DLF * tmp;
DMF = DMF * tmp;
DHF = DHF * tmp;

end

