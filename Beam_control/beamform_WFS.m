function [h, x0, xPS,Weight, Delay] = beamform_WFS(Spk_Pos, Rec_Pos, N_row, N_column)
N = N_row/8;
x0 = zeros(3, N_row*N_column);
y_temp = [8:-1:1]*0.057;
y = [];
for i = 1 : N
    y = [y, y_temp - i*8*0.057 - i*0.119];
end
z_temp = [1:N_column]*0.096;
z_temp = repmat(z_temp, N_row, 1);
z = z_temp(:).';
y = repmat(y, 1, N_column);
x0(3,:) = z;
x0(2,:) = y;
x0 = x0 - (x0(:,1)+x0(:,end))/2+Spk_Pos.';
xPS = Spk_Pos.';
xPS(1) = xPS(1)+0.5;
xPS(2) = xPS(2)+0.3;
unitn = zeros(size(x0));
unitn(1,:) = -1; 
Rec_Pos = Rec_Pos.';

% figure;
% scatter3(x0(1,:), x0(2,:),x0(3,:), '.b');
% hold on;
% scatter3(Rec_Pos(1,:), Rec_Pos(2,:),Rec_Pos(3,:), 'k');
% scatter3(xPS(1),xPS(2), xPS(3), '*');
% scatter3(Spk_Pos(1), Spk_Pos(2),Spk_Pos(3), '.k');
% xlabel('x');
% ylabel('y');
% zlabel('z');
% axis equal;


[Weight, Delay] = getWeightDelay3DWFS_Point_Source(x0, unitn, xPS, 343);
[weight_directivity] = get_3DPoint_Source_Directivity(x0,xPS, Rec_Pos, 120);
Weight = Weight.*(10.^(weight_directivity/20));

fs = 48000;
Delay_sample = round(fs*Delay)+1;
h = zeros(size(x0,2),128);
for i = 1 : size(x0,2)
    h(i,Delay_sample(i)) = Weight(i);
end
h = h./max(h, [], 'all');

fir_order = 128 - max(Delay_sample);
fir = zeros(size(x0,2),fir_order + 1);
r = vecnorm(x0 - Spk_Pos.');
f_start = 200;
f_end = 2e4;
f_cut = f_end*(f_end/f_start)^(-min(r)/(min(r) - max(r)))*(f_end/f_start).^(r/(min(r) - max(r)));
for i = 1 : length(f_cut)
    fir(i,:) = fir1(fir_order, f_cut(i)/24000);
end    
FIR = fft(fir, 128, 2);
H = fft(h, 128, 2).*FIR;
h = ifft(H, 128, 2);

end


