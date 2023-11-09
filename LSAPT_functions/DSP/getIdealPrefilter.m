function [H] = getIdealPrefilter(f,c)
%[eq.(4.31), Sch16], [eq. (2.131), Sch16], [Ch. 2.5, Sch16], 
%note that we don't divide by 2pi here, since we renormalize anyway later on
%actually srqt(1i*f) will be enough at this stage
H = transpose( sqrt(1i*2*pi*f/c) );
end