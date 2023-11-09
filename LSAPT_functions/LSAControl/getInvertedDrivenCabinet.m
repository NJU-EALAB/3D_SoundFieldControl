function [DLF,DMF,DHF] = getInvertedDrivenCabinet(DLF,DMF,DHF,MLF,MMF,MHF,NumberOfCabinet)
%solo of one cabinet
%this function assumes that LF has one piston!!!!
SoloCabDriversLF = 1:MLF:size(DLF,1);
SoloCabDriversMF = 1:MMF:size(DMF,1);
SoloCabDriversHF = 1:MHF:size(DHF,1);

i = find(SoloCabDriversLF==NumberOfCabinet);
SoloCabDriversLF = i;
SoloCabDriversMF = [SoloCabDriversMF(i):SoloCabDriversMF(i)+MMF-1];
SoloCabDriversHF = [SoloCabDriversHF(i):SoloCabDriversHF(i)+MHF-1];

DLF(SoloCabDriversLF,:) = -DLF(SoloCabDriversLF,:);
DMF(SoloCabDriversMF,:) = -DMF(SoloCabDriversMF,:);
DHF(SoloCabDriversHF,:) = -DHF(SoloCabDriversHF,:);


end

