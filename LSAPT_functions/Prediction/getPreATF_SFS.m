function [r] = getPreATF_SFS(x,x0)
N = size(x0,2); %number of secondary sources
M = size(x,2);  %number of evaluation points
%*****************************************************
%distances from secondary sources to evaluation points
%*****************************************************
r = zeros(M,N);
for n=1:N
    r(:,n) = sqrt((x(1,:) - x0(1,n)).^2 + (x(2,:) - x0(2,n)).^2 + (x(3,:) - x0(3,n)).^2);
end

%code taken from
%http://www.ee.columbia.edu/~marios/matlab/mtt.pdf
%p. 31
if 0
x = x';
x0 = x0';
i = (1:M).'; % index vector for x
i = i(:,ones(1,N)); % index matrix for x
j = 1:N; % index vector for y
j = j(ones(1,M),:); % index matrix for y
r = zeros(M, N); % initialise output matrix
r(:) = sqrt(sum(abs(x(i(:),:) - x0(j(:),:)).^2, 2));
end
%max(max(r1-r))

end

