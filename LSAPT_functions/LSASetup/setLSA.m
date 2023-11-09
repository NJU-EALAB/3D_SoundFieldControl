function LSA  = setLSA(LSA, Ac)

LSA.N = length(LSA.splay_deg);  %number of LSA cabinets

%******************
%get pistons sizes:
%Definiton for q: [eq. (3.139), Sch16, Line Piston]
%[eq. (3.144), Sch16, Circular Piston]
%******************
LSA.LF.PistonDimension = (LSA.dy0/LSA.LF.M * LSA.LF.q);
if strcmp(LSA.LF.PistonModel,'Circ')
    LSA.LF.PistonDimension = LSA.LF.PistonDimension / 2; %radius!
end
LSA.MF.PistonDimension = (LSA.dy0/LSA.MF.M * LSA.MF.q);
if strcmp(LSA.MF.PistonModel,'Circ')
    LSA.MF.PistonDimension = LSA.MF.PistonDimension / 2; %radius!
end
LSA.HF.PistonDimension = (LSA.dy0/LSA.HF.M * LSA.HF.q);
if strcmp(LSA.HF.PistonModel,'Circ')
    LSA.HF.PistonDimension = LSA.HF.PistonDimension / 2; %radius!
end

%********************
%get x0 and n of LSA:
%********************
[LSA.LF.x0, LSA.LF.unitn] = getLSASetup(LSA.N, LSA.dy0, LSA.splay_deg, LSA.xT, LSA.LF.M);
[LSA.MF.x0, LSA.MF.unitn] = getLSASetup(LSA.N, LSA.dy0, LSA.splay_deg, LSA.xT, LSA.MF.M);
[LSA.HF.x0, LSA.HF.unitn] = getLSASetup(LSA.N, LSA.dy0, LSA.splay_deg, LSA.xT, LSA.HF.M);

%********************
%Sensitivity & Power:
%********************
%this is the gain to compensate the sensitivities within one cabinet:
%from 120 dB SPL @ 1m
%later to be applied in setDrivingFunctionMaxPower
LSA.LF.Gain = getDrivingFunctionGain(LSA.LF.Sensitivity, LSA.LF.ElectricPower, Ac.p0, Ac.Pref);
LSA.MF.Gain = getDrivingFunctionGain(LSA.MF.Sensitivity, LSA.MF.ElectricPower, Ac.p0, Ac.Pref);
LSA.HF.Gain = getDrivingFunctionGain(LSA.HF.Sensitivity, LSA.HF.ElectricPower, Ac.p0, Ac.Pref);

end




