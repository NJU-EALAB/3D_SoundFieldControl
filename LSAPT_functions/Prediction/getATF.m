function ATF = getATF(r,beta,w_c,PistonModel,PistonDimension)
%matrices r and beta from getPreATF()
%w_c = 2*pi*f/c
%PistonModel: 'Line' or 'Circ'
%PistonDimension: length l or radius r0

%Kirchhoff-Diffraction: [4.29, Sch16], cf. [2.33, Sch16]
ATF = 0.5*(1+cos(beta)).*exp(-1i*w_c*r)./(4*pi*r);
%ATF = exp(-1i*w_c*r)./(4*pi*r);

if strcmp(PistonModel,'Line')
    l = PistonDimension; %[D.75, Sch16], %[4.27, Sch16]
    HPost = sinc(w_c*sin(beta)*(l/2)/pi);
elseif strcmp(PistonModel,'Circ') %[D.37, Sch16], %[4.26, Sch16]
    r0 = PistonDimension;
    HPost = 2*besselj(1,w_c*sin(beta)*r0)./(w_c*sin(beta)*r0);
    HPost(isnan(HPost)) = 1; %get rid of the NaN in the jinc-function
elseif strcmp(PistonModel,'SphericalMonopole')
    HPost = beta*0+1;
end

%no rearward radiation of pistons:
Hpost_OnOff = beta*0+1;
Hpost_OnOff(find(beta>+pi/2))=0;
Hpost_OnOff(find(beta<-pi/2))=0;

%complex-directivity point source model:
ATF=ATF.*HPost.*Hpost_OnOff;

end

