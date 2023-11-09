clear all;
directivityflag = 1;
% f_eval = [125 250 500 630 1000 2000 3150 4000 5000 6300 8000 10000];
f_eval = 1000;
M = 60; % row number
N = 60; % column number
x_st = -3;
x_ed = -16;
side_len = 1.5;
seat_x = linspace(x_st, x_ed, M);
Rcv_Pos = [];
for i1 = 1 : M 
    x_row = seat_x(i1);
    wid_row = 14 - 4 * x_row / 9;
    y_row = linspace(-wid_row/2 + side_len, wid_row/2 - side_len, N);
    z_row = -0.4 * x_row / 18 + 1.2;
    Rcv_Pos_tmp = [repmat(x_row, N, 1), repmat(z_row, N, 1), y_row.'];
    Rcv_Pos = [Rcv_Pos; Rcv_Pos_tmp];
end
Aud.x = Rcv_Pos.';
Spk_Pos = [-0.2, 2, 0];
xPS = [0.3; Spk_Pos(2)+0.2; 0];
c = 343;
interval = 0.055;
y_N = 8;
z_N = 8;
x0 = zeros(3,y_N*z_N);
x0(1,:) = Spk_Pos(1);
unitn = zeros(3,y_N*z_N);
unitn(1,:) = -1;

%% 8*8 SSD Setup

y_tmp = [-(y_N-1):2:(y_N-1)]/2*interval + Spk_Pos(2);
z_tmp = [-(z_N-1):2:(z_N-1)]/2*interval;
x0(2,:) = repmat(y_tmp, 1, z_N);
z_tmp = repmat(z_tmp,y_N,1);
z_tmp = z_tmp(:).';
x0(3,:) = z_tmp;
% [h0, x0, xPS] = beamform_WFS(Spk_Pos, Rcv_Pos, 16, 4);
%% 16*4 SSD Setup
M = 8; % row number
N = 8; % column number
x_st = -10;
x_ed = -45;
side_len = 1.5;
seat_x = linspace(x_st, x_ed, M);
Rcv_Pos = [];
for i1 = 1 : M 
    x_row = seat_x(i1);
    wid_row = 30 - 10 * x_row / 49.99;
    y_row = linspace(-wid_row/2 + side_len, wid_row/2 - side_len, N);
    z_row = -10 * x_row / 49.99 + 1.2;
    Rcv_Pos_tmp = [repmat(x_row, N, 1), repmat(z_row, N, 1), y_row.'];
    Rcv_Pos = [Rcv_Pos; Rcv_Pos_tmp];
end
num_left = find(Rcv_Pos(:,3) >= 0);
num_right = find(Rcv_Pos(:,3) < 0);
Rcv_Pos = Rcv_Pos([num_left, num_right],:);
Spk_Pos = [-0.5, 3, 8];
[h0, x0, xPS,Weight, Delay] = beamform_WFS(Spk_Pos, Rcv_Pos(33:64,:), 8, 8);
%%
% [Weight, Delay] = getWeightDelay3DWFS_Point_Source(x0, unitn, xPS, c);
% [weight_directivity] = get_3DPoint_Source_Directivity(x0,xPS, Aud.x, 120);
% if directivityflag == 1
%     Weight = Weight.*(10.^(weight_directivity/20));
% end
%%
z = -8:0.1:24;
x = -45: 0.1 : -1;
y = 0:0.1:16;
z_ver = 0;
y_hor = 1.4;
[X,Z] = meshgrid(x,z);
x_eval_hor = X(:);
z_eval_hor = Z(:);
xeval_hor = zeros(3, length(x_eval_hor));
xeval_hor(1,:) = x_eval_hor;
xeval_hor(2,:) = y_hor;
xeval_hor(3,:) = z_eval_hor;

[X,Y] = meshgrid(x,y);
x_eval_ver = X(:);
y_eval_ver = Y(:);
xeval_ver = zeros(3, length(x_eval_ver));
xeval_ver(1,:) = x_eval_ver;
xeval_ver(2,:) = y_eval_ver;
xeval_ver(3,:) = z_ver;
figure;

f = f_eval;
G = freeField3dATF(x0, xeval_ver, 2*pi*f/c);
D = (Weight).*exp(-1j*2*pi*f*Delay);
D = D.';
P = reshape(20*log10(abs(G*D)),length(y), []);
imagesc(x,y,P);
set(gca,'YDir','normal');
hold on;
    %     contour(x,y,P, [min(P,[], 'all'):1:max(P,[], 'all')], 'Color',[0.5 0.5 0.7]);
scatter3(xPS(1), xPS(2),xPS(3), '*');
scatter3(x0(1,:), x0(2,:), x0(3,:),'.k');
scatter3(Aud.x(1,:), Aud.x(2,:),Aud.x(3,:), '.k');
axis equal;
xlabel('x'); ylabel('y');
title(['f =', num2str(f),'Hz']);
colorbar;

% for i = 1 : length(f_eval)
%     f = f_eval(i);
%     subplot(4,3,i);
%     G = freeField3dATF(x0, xeval_ver, 2*pi*f/c);
%     D = (Weight).*exp(-1j*2*pi*f*Delay);
%     D = D.';
%     P = reshape(20*log10(abs(G*D)),length(y), []);
%     imagesc(x,y,P);
%     set(gca,'YDir','normal');
%     hold on;
% %     contour(x,y,P, [min(P,[], 'all'):1:max(P,[], 'all')], 'Color',[0.5 0.5 0.7]);
%     scatter(xPS(1), xPS(2), '*');
%     scatter(x0(1,:), x0(2,:), '.k');
%     scatter(Aud.x(1,:), Aud.x(2,:), '.k');
%     axis equal;
%     xlabel('x'); ylabel('y');
%     title(['f =', num2str(f),'Hz']);
%     colorbar;
% end
% figure;
% for i = 1 : length(f_eval)
%     f = f_eval(i);
%     subplot(4,3,i);
%     G = freeField3dATF(x0, xeval_hor, 2*pi*f/c);
%     D = (Weight).*exp(-1j*2*pi*f*Delay);
%     D = D.';
%     P = reshape(20*log10(abs(G*D)),length(z), []);
%     imagesc(x,z,P);
%     set(gca,'YDir','normal');
%     hold on;
%     contour(x,z,P, [min(P,[], 'all'):6:max(P,[], 'all')], 'Color',[0.5 0.5 0.7]);
%     scatter(xPS(1), xPS(3), '*');
%     scatter(x0(1,:), x0(3,:), '.k');
% %     scatter(Aud.x(1,:), Aud.x(3,:), '.k');
%     axis equal;
%     xlabel('x'); ylabel('z');
%     title(['f =', num2str(f),'Hz']);
%     colorbar;
% end
% fs = 48000;
% Delay_sample = round(fs*Delay)+1;
% h = zeros(size(x0,2),128);
% for i = 1 : size(x0,2)
%     h(i,Delay_sample(i)) = Weight(i);
% end
% dt = datestr(now,'yyyymmddTHHMMSS');
% save(['h', dt, '.mat'], 'h');