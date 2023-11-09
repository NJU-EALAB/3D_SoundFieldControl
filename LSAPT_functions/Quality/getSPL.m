%% SPL Metering
PAud(1,:)=0;
PAud(end,:)=0;

%% A-Filter:
[b,a,B,A] = AFilter(Ac.fs);
H_AFilter = transpose(freqs(B,A,2*pi*Ac.f));
H_AFilter = repmat(H_AFilter,1,size(PAud,2));
%% Pink Noise-Filter:
H_PN = 1./sqrt(Ac.f);
H_PN(1) = 0;
H_PN = transpose(H_PN);
%% Highpass:
[b,a] = butter(LSA.NHP,2*pi*LSA.fHP,'high','s');
H_HP = transpose(abs(freqs(b,a,2*pi*Ac.f)));
%% Lowpass:
[b,a] = butter(LSA.NLP,2*pi*LSA.fLP,'s');
H_LP = transpose(abs(freqs(b,a,2*pi*Ac.f)));

H_PN = H_PN .* H_LP .* H_HP; %apply band limits to the Pink Noise
H_PN = H_PN/max(H_PN); %apply 0dB max
H_PN = repmat(H_PN,1,size(PAud,2));

if 0
figure(fh2)
semilogx(Ac.f,20*log10(abs(H_AFilter(:,1)))), hold on
semilogx(Ac.f,20*log10(abs(H_PN(:,1)))), hold off
xlabel('f/Hz')
ylabel('A/dB')
grid on
end
%apply filters:
PAud_AFilter = PAud .* H_AFilter;
PAud_PN = PAud .* H_PN;
PAud_PN_AFilter = PAud .* H_PN .* H_AFilter;

dB_SPL_White = 20*log10(sqrt(2/size(PAud,1)*sum(abs(PAud).^2,1))/Ac.p0);
dB_SPL_White_A = 20*log10(sqrt(2/size(PAud_AFilter,1)*sum(abs(PAud_AFilter).^2,1))/Ac.p0);
dB_SPL_Pink = 20*log10(sqrt(2/size(PAud_PN,1)*sum(abs(PAud_PN).^2,1))/Ac.p0);
dB_SPL_Pink_A = 20*log10(sqrt(2/size(PAud_PN_AFilter,1)*sum(abs(PAud_PN_AFilter).^2,1))/Ac.p0);
%clc
dB_SPL_White - dB_SPL_Pink; %Crest White vs. Pink Noise
