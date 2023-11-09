function G = freeField3dATF(x_src, x_sen, k, ATFType)
% get acoustic transfer function matrix of point source in 3D free field
% ATFType: 1 -> -jkx+jwt; 0 -> jkx-jwt
%%
if nargin < 4
    ATFType = 1;
end

k = k(:);
assert(size(x_src,1) == 3);
assert(size(x_sen,1) == 3);
%%
K = length(k);
G = zeros(size(x_sen,2),size(x_src,2),K);
for ii = 1:K
    G(:,:,ii) = getATF_(x_src, x_sen, k(ii), ATFType);
end
end

%%
%%
function G = getATF_(x_src, x_sen, k, ATFType)
assert(length(k) == 1);
R = getR(x_src, x_sen);
if ATFType
    G = exp(-1j*k*R)./(4*pi*R);
else
    G = exp(1j*k*R)./(4*pi*R);
end
end

function R = getR(x_src, x_sen)
assert(size(x_src,1)==3);
assert(size(x_sen,1)==3);
R = zeros(size(x_sen,2),size(x_src,2));
for idx = 1:size(x_src,2)
    R(:,idx) = vecnorm(x_sen-x_src(:,idx),2,1).';
end
end
