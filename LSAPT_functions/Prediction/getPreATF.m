function [r,beta] = getPreATF(x,x0,unitn)
N = size(x0,2); %number of secondary sources
M = size(x,2);  %number of evaluation points
%*****************************************************
%distances from secondary sources to evaluation points
%*****************************************************
r = zeros(M,N);
for n=1:N
    r(:,n) = sqrt((x(1,:) - x0(1,n)).^2 + (x(2,:) - x0(2,n)).^2 + (x(3,:) - x0(3,n)).^2);
end
%********************************************************
%angle beta between main lobe direction and [x-x0]-vector
%for piston directivity and Kirchhoff diffraction
%********************************************************
beta = r*0;
for m=1:M       %do for all evaluation points
    for n=1:N   %do for all secondary sources
        x_x0 = x(:,m) - x0(:,n); %get all combinations x(m)-x0(n)
        beta(m,n) = acos(dot(x_x0,unitn(:,n))/(norm(x_x0)*norm(unitn(:,n))));
    end
end

end

