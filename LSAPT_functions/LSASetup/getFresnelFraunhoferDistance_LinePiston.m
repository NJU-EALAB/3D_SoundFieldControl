function xB = getFresnelFraunhoferDistance_LinePiston(fmax,L,c)
%[D.79, Sch16]
f = 0:1:fmax;
f = [f fmax];
xB = real((1/2*L^2*f/c).*sqrt(1-1./(f/c*L).^2)); 
%Fresnel/Fraunhofer transition distance Heil1992 Line
disp('********************************************************')
disp(['min xREF=',num2str(max(xB)),'m to be in Fraunhofer region@',num2str(fmax/1000),'kHz'])
disp('********************************************************')
end