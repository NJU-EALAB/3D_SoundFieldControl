function plotPPlane(fh,fhCBSPLxy,x,y,xVenue,f,P,p0,pl)
figure(fh)
for n=1:length(f)
    if length(f)==1
        %no subplots
    else
        h1 = subplot(4,3,n);
        %h1 = subplot(3,2,n);
        %Matlab Bug: colorbar and subplot shrinks figures
        %https://groups.google.com/forum/#!topic/comp.soft-sys.matlab/N6Q-LAK014c
        ax1 = get(h1,'position');
        set(h1,'position',ax1);
    end
    %surf(x,y,20*log10(abs(P(:,:,n)/p0))), hold on
    imagesc(x, y, 20*log10(abs(P(:,:,n)/p0))), hold on
    set(gca,'YDir','normal')
    if pl.IsobarFlag
        contour(x, y, 20*log10(abs(P(:,:,n)/p0)),[pl.IsobarMin:pl.IsobarStep:pl.IsobarMax],'Color',[0.5 0.5 0.7])
    end
    plot3(xVenue(1,:),xVenue(2,:),xVenue(1,:)*0+200,'k','LineWidth',1.5)
    
    hold off
    shading flat
    view([0 90])
    axis equal
    axis([pl.xmin pl.xmax pl.ymin pl.ymax])
    set(gca,'XTick',[pl.xmin:pl.dx:pl.xmax])
    set(gca,'YTick',[pl.ymin:pl.dy:pl.ymax])
    N_cm = abs((pl.Max_dB-pl.Min_dB)/pl.Step_dB);
    cm = cbrewer(pl.CMType, pl.CM, N_cm);
    if pl.CMFlip
        cm = flipud(cm);
    end
    colormap(cm)
    set(gca,'CLim',[pl.Min_dB pl.Max_dB])
    if n==11
        xlabel('x / m')
    end
    if n==1||n==4||n==7||n==10
        ylabel('y / m')
    end
    title(['f=',num2str(f(n)),'Hz'])
end

%% single colorbar
%http://stackoverflow.com/questions/16763440/how-to-plot-save-only-the-colorbar-in-matlab
figure(fhCBSPLxy);
axis off
colormap(cm);
caxis([pl.Min_dB pl.Max_dB]);
% h = colorbar([0.1 0.1  0.8  0.7],...
%     'location','EastOutside',...
%     'YTick',[pl.Min_dB:pl.ddB:pl.Max_dB],...
%     'YTickLabel',[pl.Min_dB:pl.ddB:pl.Max_dB]);
% set(h,'OuterPosition',[0.1 0.1 0.8 0.8]);
% ylabel(h,'A / dB_{SPL}')

end


