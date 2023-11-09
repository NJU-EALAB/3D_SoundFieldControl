function D = getDrivingFunctionWFS_PointSource_f(x0,unitn,xPS,xRef,f,c,RefFlag)
% we implement the 2.5D WFS driving function for a non-focused point source
% (i) with reference point correction -> RefFlag = 'Point'
% cf. [Sta97,(3.10,3.11)], [Sch16,(2.137)]
% xRef is here a vector
% (ii) with parallel reference line correction -> RefFlag = 'Line'
% cf. [Sta97,(3.16,3.17)], [Sch16,(2.131)]
% xRef is here a distance

% input:
% x0 [3xN] matrix for N secondary source positions w.r.t x,y,z coordinates
% unitn [3xN] matrix for the inward unit normal of the N secondary source positions
% xPS [3x1] vector for the point source position
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
% [Sta97] Start, E.W. (1997): Direct Sound Enhancement by Wave Field Syn-
% thesis. Ph.D. thesis, Delft University of Technology.
% [Spo08b] Spors, S.; Rabenstein, R.; Ahrens, J. (2008): The theory of Wave
% Field Synthesis revisited. In: Proc. of the 124th Audio Eng. Soc.
% Convention, Amsterdam, #7358.

D = zeros(size(x0,2),size(f,2)); %alloc matrix

if strcmp(RefFlag,'Point') %[Sta97,(3.10,3.11)], [Sch16,(2.137)]
    xPS = repmat(xPS,1,size(x0,2)); %prepare a point source position matrix
    xRef = repmat(xRef,1,size(x0,2)); %prepare a ref point position matrix
    x0xPS  = x0-xPS; %get all vectors x0-xPS into a matrix
    xRefx0 = xRef-x0; %get all vectors xRef-x0 into a matrix
    dot_x0xPS_n = dot(x0xPS,unitn);         %dot product <x0-xPS,n(x0)>
    norm_x0xPS = sqrt(sum(x0xPS.^2,1));   %|x0-xPS|
    norm_xRefx0 = sqrt(sum(xRefx0.^2,1)); %|xRef-x0|
    SecSrcSel = (dot_x0xPS_n./norm_x0xPS > 0)'; %cos phi_s > 0 ?
    
    A = SecSrcSel .* transpose( 1/sqrt(2*pi) *...
        sqrt( norm_xRefx0 ./ (norm_x0xPS+norm_xRefx0) ) .*...
        dot_x0xPS_n ./ norm_x0xPS.^(3/2) );
    
    for n=1:length(f)
        w_c = 2*pi*f(n)/c;
        D(:,n) = sqrt(1i*w_c) *... %prefilter
            transpose(exp( -1i*w_c * norm_x0xPS )); %phasor
        D(:,n) = A .* D(:,n); %gain + sec src sel
    end
    
elseif strcmp(RefFlag,'Line') %[Sta97,(3.16,3.17)], [Sch16,(2.131)]
    delta_rPS = dot(x0(:,1) - xPS,unitn(:,1)); %get distance point source to SSD
    %note that any x0,unitn can be used
    g = sqrt(xRef/(xRef+delta_rPS)); %gain factor for line correction
    
    xPS = repmat(xPS,1,size(x0,2)); %prepare a point source position matrix
    x0xPS  = x0-xPS; %get all vectors x0-xPS into a matrix
    dot_x0xPS_n = dot(x0xPS,unitn);       %dot product <x0-xPS,n(x0)>
    norm_x0xPS = sqrt(sum(x0xPS.^2,1));   %|x0-xPS|
    SecSrcSel = (dot_x0xPS_n./norm_x0xPS > 0)'; %cos phi_s > 0 ?
    
    A = SecSrcSel .* transpose( g / sqrt(2*pi) * dot_x0xPS_n ./ norm_x0xPS.^(3/2));
    
    for n=1:length(f)
        w_c = 2*pi*f(n)/c;
        D(:,n) = sqrt(1i*w_c) *... %prefilter
            transpose(exp( -1i*w_c * norm_x0xPS )); %phasor
        D(:,n) = A .* D(:,n); %gain + sec src sel
    end
else
    
end

end

