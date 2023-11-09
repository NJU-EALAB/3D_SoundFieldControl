function PDistribution = getPLineDistribution(P,f,fStart,fStop,p0)
%[eq. (4.42), Sch16]
PDistribution = quantile(20*log10(abs(P(f>fStart & f<fStop,:)/p0)),[0.05 0.25 0.50 0.75 0.95]); 
PDistribution = round(PDistribution*10)/10;
end

