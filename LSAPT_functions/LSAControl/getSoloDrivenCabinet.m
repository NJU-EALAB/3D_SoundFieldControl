function [DLF,DMF,DHF] = getSoloDrivenCabinet(DLF,DMF,DHF,MLF,MMF,MHF,NumberOfCabinet)
%solo of one cabinet
%this function assumes that LF has one piston!!!!
SoloCabDriversLF = 1:MLF:size(DLF,1);
SoloCabDriversMF = 1:MMF:size(DMF,1);
SoloCabDriversHF = 1:MHF:size(DHF,1);

i = find(SoloCabDriversLF==NumberOfCabinet);
SoloCabDriversLF = i;
SoloCabDriversMF = [SoloCabDriversMF(i):SoloCabDriversMF(i)+MMF-1];
SoloCabDriversHF = [SoloCabDriversHF(i):SoloCabDriversHF(i)+MHF-1];

DLF(1:SoloCabDriversLF(1)-1,:) = 0;
DLF(SoloCabDriversLF(end)+1:end,:) = 0;
DMF(1:SoloCabDriversMF(1)-1,:) = 0;
DMF(SoloCabDriversMF(end)+1:end,:) = 0;
DHF(1:SoloCabDriversHF(1)-1,:) = 0;
DHF(SoloCabDriversHF(end)+1:end,:) = 0;

end

