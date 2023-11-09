function [x0, unitn] = getLSASetup(N,dy0,splay_deg,xTop,M)
%N number of LSA cabinets
%M number of pistons per LSA cabinet, const. for all cabinets!
%dy0 spacing between adjacent LSA cabinet centers
%splay_deg tilting angles in deg
%xTop position vector of top LSA cabinet when not tilted

% eq. (1)-(3) of
% Straube, F.; Schultz, F. & Weinzierl, S. (2015): 
% "Evaluation Strategies for the Optimization of Line Source Arrays Proc. of 
% the 59th Intl. Audio Eng. Soc. Conference, Montreal." 

% see [p.197,Sch16], [Fig. 4.12,Sch16]


gamma = cumsum(-splay_deg)*pi/180; %pay attention to the here chosen angle definition!!!
%out of the splay_degs

for n=1:N
    %top coordinates LSA elements:
    tmp_sin = 0;
    tmp_cos = 0;
    for mu=1:n-1
        tmp_sin = tmp_sin + dy0*sin(gamma(mu));
        tmp_cos = tmp_cos + dy0*cos(gamma(mu));
    end
    xtn(n) = xTop(1,1) - tmp_sin;
    ytn(n) = xTop(2,1) - tmp_cos;
    
    %bottom coordinates LSA elements:
    tmp_sin = 0;
    tmp_cos = 0;
    for mu=1:n
        tmp_sin = tmp_sin + dy0*sin(gamma(mu));
        tmp_cos = tmp_cos + dy0*cos(gamma(mu));
    end
    xbn(n) = xTop(1,1) - tmp_sin;
    ybn(n) = xTop(2,1) - tmp_cos;
end

x0 = zeros(3,M*N);
unitn = zeros(3,M*N);
for n=1:N
    R = rotz(-gamma(n)); %pay attention to the here chosen angle definition!!!
    for m=1:M
        i=(n-1)*M+m;
        x0(1,i) = xtn(n) + ((m-0.5)/M)*(xbn(n)-xtn(n));
        x0(2,i) = ytn(n) + ((m-0.5)/M)*(ybn(n)-ytn(n));
        unitn(:,i) = R*[1;0;0];
    end
end

end
