function f = getFrequencies(df,fs)
f = 0:df:fs/2; %Hz, DFT frequency vector, we don't check if this is correct, chk fs/2 and df for feasibility, length of DFT must be even
end