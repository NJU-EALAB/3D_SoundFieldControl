clear all; close all;
fig_pos = [400, 170, 400, 300];
if 0 %my office monitor
fh1 = figure('name','LSA & Venue','position',[ 833        2114         262         161]);
fh2 = figure('name','Single Cabinet','position',[ 833        2349         262         161]);
fh3 = figure('name','SPLxy','position',[263         906        1039         344]);
%fh3 = figure('name','SPLxy','position',[257         901        1050        1613]);
fh4 = figure('name','FAP','position',[ 263        1325        1042         193]);
fh5 = figure('name','IR','position',[263        1892         293         147]);
fh6 = figure('name','FRP','position',[564        2113         261         160]);
fh7 = figure('name','DFIP LF','position',[1103        2348         203         162]);
fh8 = figure('name','DFIP MF','position',[  1103        2117         201         156]);
fh9 = figure('name','DFIP HF','position',[ 1103        1889         200         154]);
fh10 = figure('name','Pressure Distribution','position',[262        1594         431         223]);
fh11 = figure('name','PIP','position',[699        1595         605         222]);
fh12 = figure('name','Spline Interp','position',[ 263        2113         293         396]);
fh13 = figure('name','Polar Plot PS','position',[  564        2349         260         160]);
fh14 = figure('name','WFS D Delays','position',[ 563        1892         532         149]);
fh15 = figure('name','LB1','position',[400, 170, 400, 300]);
fh16 = figure('name','LB2','position',[400, 170, 400, 300]);
fh17 = figure('name','DI','position',[400, 170, 400, 300]);
fh18 = figure('name','Avoid Freq Resp','position',[400, 170, 400, 300]);
fhCBSPLxy = figure('name','SPLxy Colorbar','position',[400, 170, 400, 300]);
fh19 = figure('name','DwS','position',[257         901        1050        1613]);
fh20 = figure('name','DwSH','position',[257         901        1050        1613]);
end

if 0 %my home monitor
fh1 = figure('name','LSA & Venue','position',[ 170        1125         452         168]);
fh2 = figure('name','Single Cabinet','position',[ 631        1123         378         168]);
fh3 = figure('name','SPLxy','position',[ 171        1369         841         539]);
fh4 = figure('name','FAP','position',[1019        1671         760         234]);
fh5 = figure('name','IR','position',[ 630   908   282   140]);
fh6 = figure('name','FRP','position',[-130        1673         293         235]);
fh7 = figure('name','DFIP LF','position',[ 921   907   280   142]);
fh8 = figure('name','DFIP MF','position',[ 1208         907         280         140]);
fh9 = figure('name','DFIP HF','position',[1497         907         280         140]);
fh10 = figure('name','Pressure Distribution','position',[1019        1364         760         232]);
fh11 = figure('name','PIP','position',[1018        1127         762         162]);
fh12 = figure('name','Spline Interp','position',[ -132   908   292   384]);
fh13 = figure('name','Polar Plot PS','position',[  -132        1367         293         231]);
fh14 = figure('name','WFS D Delays','position',[ 171   908   450   142]);
fh15 = figure('name','LB1','position',[400, 170, 400, 300]);
fh16 = figure('name','LB2','position',[400, 170, 400, 300]);
fh17 = figure('name','DI','position',[400, 170, 400, 300]);
fh18 = figure('name','Avoid Freq Resp','position',[400, 170, 400, 300]);
fhCBSPLxy = figure('name','SPLxy Colorbar','position',[400, 170, 400, 300]);
fh19 = figure('name','DwS','position',[400, 170, 400, 300]);
fh20 = figure('name','DwSH','position',[400, 170, 400, 300]);
end

if 1 %if no external screen
fh1 = figure('name','LSA & Venue','position',fig_pos);
fh2 = figure('name','Single Cabinet','position',fig_pos);
fh3 = figure('name','SPLxy','position',fig_pos);
fh4 = figure('name','FAP','position',fig_pos);
fh5 = figure('name','IR','position',fig_pos);
fh6 = figure('name','FRP','position',fig_pos);
fh7 = figure('name','DFIP LF','position',fig_pos);
fh8 = figure('name','DFIP MF','position',fig_pos);
fh9 = figure('name','DFIP HF','position',fig_pos);
fh10 = figure('name','Pressure Distribution','position',fig_pos);
fh11 = figure('name','PIP','position',fig_pos);
fh12 = figure('name','Spline Interp','position',fig_pos);
fh13 = figure('name','Polar Plot PS','position',fig_pos);
fh14 = figure('name','WFS D Delays','position',fig_pos);
fh15 = figure('name','LB1','position',fig_pos);
fh16 = figure('name','LB2','position',fig_pos);
fh17 = figure('name','DI','position',fig_pos);
fh18 = figure('name','Avoid Freq Resp','position',fig_pos);
fhCBSPLxy = figure('name','SPLxy Colorbar','position',fig_pos);
fh19 = figure('name','DwS','position',[400, 170, 400, 300]);
fh20 = figure('name','DwSH','position',[400, 170, 400, 300]);
end






save fighandles