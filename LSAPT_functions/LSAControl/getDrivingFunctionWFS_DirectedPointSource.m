%% 2015-11-11 
%this realizes the WFS Point Source with Directivity driving functions
%[eq. (4.33), Sch16]
function [...
    DLF, DMF, DHF,...
    DlyLF, DlyMF, DlyHF,...
    phiPS_deg, GainPS_dB,...
    phiPS_LSA_deg_LF, GainPS_LSA_dB_LF,...
    phiPS_LSA_deg_MF, GainPS_LSA_dB_MF,...
    phiPS_LSA_deg_HF, GainPS_LSA_dB_HF...
    ] = ...
    getDrivingFunctionWFS_DirectedPointSource(...
    x0LF, unitnLF,...
    x0MF, unitnMF,...
    x0HF, unitnHF,...
    x, xPS, xRef,...
    dBmin, dBDD,...
    f,c,PointSourceDirectivityFlag)
%% get WFS driving functions of a virtual point source in freq domain:
DLF = getDrivingFunctionWFS_PointSource_f(x0LF,unitnLF,xPS,xRef,f,c,'Point');
DMF = getDrivingFunctionWFS_PointSource_f(x0MF,unitnMF,xPS,xRef,f,c,'Point');
DHF = getDrivingFunctionWFS_PointSource_f(x0HF,unitnHF,xPS,xRef,f,c,'Point');

%% get the delays (we don't need the gain==tmp)
[tmp, DlyLF] = getDrivingFunctionWFS_PointSource_t(x0LF,unitnLF,xPS,xRef,c,'Point');
[tmp, DlyMF] = getDrivingFunctionWFS_PointSource_t(x0MF,unitnMF,xPS,xRef,c,'Point');
[tmp, DlyHF] = getDrivingFunctionWFS_PointSource_t(x0HF,unitnHF,xPS,xRef,c,'Point');

%% we compensate the traveling time of the PS towards the LSA, so the LSA starts to
% radiate at t=0s
minDly = min([DlyLF; DlyMF; DlyHF]);
DlyLF = DlyLF - minDly;
DlyMF = DlyMF - minDly;
DlyHF = DlyHF - minDly;

%% we estimate the ideal virtual PS farfield directivity pattern based on
% xPS, x and xRef
[phiPS_deg, GainPS_dB] = get_PointSource_Directivity(x,xPS,xRef,dBmin,dBDD);

if ~PointSourceDirectivityFlag
    GainPS_dB = GainPS_dB*0; %realize a simple PS with no directivity
end

%% now get the real gain for the WFS driving function according to xPS and x0
% using cubic spline interpolation from the ideal virtual PS farfield
% directivity pattern:
[phiPS_LSA_deg_LF, GainPS_LSA_dB_LF] = get_PointSource_DirectivityGain(x0LF,xPS,phiPS_deg,GainPS_dB);
[phiPS_LSA_deg_MF, GainPS_LSA_dB_MF] = get_PointSource_DirectivityGain(x0MF,xPS,phiPS_deg,GainPS_dB);
[phiPS_LSA_deg_HF, GainPS_LSA_dB_HF] = get_PointSource_DirectivityGain(x0HF,xPS,phiPS_deg,GainPS_dB);

%% apply the frequency independent (i.e. an adapted window!!!)
%(but cabinet dependent) gain to the
% raw WFS driving functions
if PointSourceDirectivityFlag %use this if we want to apply the PS FRP
    %otherwise a simple PS is synthesized using the WFS driving function
    %straightforwardly
    %[eq. (4.37), Sch16]
    DLF = DLF .* repmat(10.^(GainPS_LSA_dB_LF/20),1,size(DLF,2));
    DMF = DMF .* repmat(10.^(GainPS_LSA_dB_MF/20),1,size(DMF,2));
    DHF = DHF .* repmat(10.^(GainPS_LSA_dB_HF/20),1,size(DHF,2));
end

end

