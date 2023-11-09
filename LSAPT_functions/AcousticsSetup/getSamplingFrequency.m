function fs = getSamplingFrequency(varargin)
if nargin==0
    fs = 48000; %Hz
else
    fs=varargin{1};
end
end