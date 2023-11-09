function [h,k] = getFractionalDerivativeFIR(N)
%[eq. (2.198), Sch16]
k = -(N-1)/2:1:+(N-1)/2;

arg34 = exp(1i*3/4*pi)*sqrt(pi*k);
arg14 = exp(1i*1/4*pi)*sqrt(pi*k);

erf34 = mfun('erf',arg34);
erf14 = mfun('erf',arg14);

%h = (sqrt(8*k).*cos(pi*k) + erf34 - erf14).* ((4*sqrt(pi)*k.^(3/2))).^(-1);
h = (sqrt(8*k).*cos(pi*k) + erf34 - erf14)./ ((4*sqrt(pi)*k.^(3/2)));
h((N-1)/2+1) = sqrt(pi*2/9); %treat k=0
disp('max imag:')
max(abs(imag(h)))
h = real(h);

end

