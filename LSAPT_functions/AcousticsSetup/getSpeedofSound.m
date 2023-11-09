function c = getSpeedofSound(varargin)
%varargin -> temperature in °C
if nargin==0
    c = 343;
else
    c = (331.4+0.6*varargin{1});
end
end