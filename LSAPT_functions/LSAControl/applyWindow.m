function [DLF, DMF, DHF] = applyWindow(DLF, DMF, DHF, betaKB)
%Harris, F. J. On the use of windows for harmonic analysis with the discrete
%fourier transform Proc. of the IEEE, 1978, 66, 51-83

wLF = kaiser(size(DLF,1),betaKB);
wLF = repmat(wLF,[1 size(DLF,2)]);

wMF = kaiser(size(DMF,1),betaKB);
wMF = repmat(wMF,[1 size(DMF,2)]);

wHF = kaiser(size(DHF,1),betaKB);
wHF = repmat(wHF,[1 size(DHF,2)]);

DLF = DLF .* wLF;
DMF = DMF .* wMF;
DHF = DHF .* wHF;

end
