function [r,beta] = getPreATF_Fast(x,x0,unitn)
%this version is much faster than getPreATF for large N and M due to
%efficient matrix processing:
%see [eq. 4.29,Sch16], [Table 4.1&4.2, Sch16]

N = size(x0,2); %number of secondary sources
M = size(x,2);  %number of evaluation points

%dot product using matrices
X = permute(repmat(x,[1 1 N]),[1 3 2]);
X0 = (repmat(x0,[1 1 M]));
UNITN = (repmat(unitn,[1 1 M]));
beta = (dot(X-X0,UNITN,1));
beta = squeeze(permute(beta,[1,3,2]));

%code taken from
%http://www.ee.columbia.edu/~marios/matlab/mtt.pdf
%p. 31
x_tmp = x';
x0_tmp = x0';
i = (1:M).'; % index vector for x
i = i(:,ones(1,N)); % index matrix for x
j = 1:N; % index vector for y
j = j(ones(1,M),:); % index matrix for y
r = zeros(M, N); % initialise output matrix
r(:) = sqrt(sum(abs(x_tmp(i(:),:) - x0_tmp(j(:),:)).^2, 2));

if N == 1 %beta and r vectors have different dimensions then, transpose beta
    beta = acos(beta'./r);
else
    beta = acos(beta./r);
end
end

