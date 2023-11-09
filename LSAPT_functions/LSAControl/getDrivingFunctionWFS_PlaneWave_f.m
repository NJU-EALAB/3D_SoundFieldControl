function D = getDrivingFunctionWFS_PlaneWave_f(x0,unitn,nPW,xRef,f,c,RefFlag)
% we implement the 2.5D WFS driving function for a plane wave
% (i) with reference point correction -> RefFlag = 'Point'
% cf. [Sch16,(2.177)], cf. [Spo08b, (27)]
% xRef is here a vector
% (ii) with parallel reference line correction -> RefFlag = 'Line'
% cf. [Sch16,(2.170)], cf. [Ahr10, (29)]
% xRef is here a distance

% input:
% x0 [3xN] matrix for N secondary source positions w.r.t x,y,z coordinates
% unitn [3xN] matrix for the inward unit normal of the N secondary source positions
% nPW [3x1] vector for the plane wave propagating direction
% xref: either [3x1] vector for (i) or [1x1] value for (ii)
% f [1xM] frequency vector with M frequencies, e.g. DFT bins from DC to
% fs/2
% c [1x1] value for speed of sound in m/s, e.g. 343 m/s
% RefFlag: (i) 'Point', (ii) 'Line'

% output:
% D [NxM] matrix of driving functions, i.e. the Fourier spectra
% here one column represents the N weights per frequency to process SFS as
% p = ATF * d for a single frequency

% references:
% [Spo08b] Spors, S.; Rabenstein, R.; Ahrens, J. (2008): The theory of Wave
% Field Synthesis revisited. In: Proc. of the 124th Audio Eng. Soc.
% Convention, Amsterdam, #7358.
% [Ahr10] Ahrens, J.; Spors, S. (2010): Sound field reproduction using planar
% and linear arrays of loudspeakers. In: IEEE Trans. Audio Speech
% Language Process., 18(8):2038–2050.

D = zeros(size(x0,2),size(f,2)); %alloc matrix

if strcmp(RefFlag,'Point') %[Sch16,(2.177)], [Spo08b, (27)]
    nPW = repmat(nPW,1,size(x0,2)); %prepare a wave direction matrix
    xRef = repmat(xRef,1,size(x0,2)); %prepare a ref point position matrix
    xRefx0 = xRef-x0; %get all vectors xRef-x0 into a matrix
    norm_xRefx0 = sqrt(sum(xRefx0.^2,1)); %|xRef-x0|
    dot_nPWunitn = dot(nPW,unitn); %dot product <nPW,n(x0)>
    dot_nPWx0 = dot(nPW,x0); %dot product <nPW,x0>
    SecSrcSel = (dot_nPWunitn > 0)'; %cos phi_p > 0 ?
    
    A = SecSrcSel .* transpose( sqrt(8*pi) *...
        sqrt(norm_xRefx0) .* dot_nPWunitn);
    
    for n=1:length(f)
        w_c = 2*pi*f(n)/c;
        D(:,n) = sqrt(1i*w_c) *... %prefilter
            transpose(exp( -1i*w_c * dot_nPWx0 )); %phasor
        D(:,n) = A .* D(:,n); %gain + sec src sel
    end
    
elseif strcmp(RefFlag,'Line') %[Sch16,(2.170)], cf. [Ahr10, (29)]
    nPW = repmat(nPW,1,size(x0,2)); %prepare a wave direction matrix
    dot_nPWunitn = dot(nPW,unitn); %dot product <nPW,n(x0)>
    dot_nPWx0 = dot(nPW,x0); %dot product <nPW,x0>
    SecSrcSel = (dot_nPWunitn > 0)'; %cos phi_p > 0 ?
    
    A = SecSrcSel .* transpose( sqrt(8*pi*xRef) *...
        sqrt(dot_nPWunitn));
    
    for n=1:length(f)
        w_c = 2*pi*f(n)/c;
        D(:,n) = sqrt(1i*w_c) *... %prefilter
            transpose(exp( -1i*w_c * dot_nPWx0 )); %phasor
        D(:,n) = A .* D(:,n); %gain + sec src sel
    end
else
    
end

end

