function [weight_directivity] = get_3DPoint_Source_Directivity(x,xPS, Rec_Pos, dBmin)
[theta_aud, phi_aud] = CalAngle3D(xPS, Rec_Pos);
[theta_spk,phi_spk] = CalAngle3D(xPS, x);
weight = 20*log10(vecnorm(Rec_Pos - xPS));

% [max_theta, ~] = max(theta_aud);
% [min_theta, ~] = min(theta_aud);
% theta_up =  (max_theta) :0.5: 77;
% theta_down = -77 : (min_theta);
% theta_extend_temp = [theta_down, theta_up];
phi_temp = -90 :0.5: 90;
% theta_extend_test = repmat(theta_extend_temp,length(phi_temp),1);
% theta_extend_test = theta_extend_test(:);
% theta_extend_test = [theta_aud, theta_extend_test.'];
% phi_extend_test = repmat(phi_temp, 1, length(theta_extend_temp));
% phi_extend_test = [phi_aud, phi_extend_test];

edge = zeros(2,2*length(phi_temp));
edge(2,:) = repmat(phi_temp, 1,2);
edge(1,1:end/2) = 77;
edge(1,end/2+1 :end) = -77;
weight_extend = [weight, -dBmin*ones(1,length(edge))];
theta_extend = [theta_aud, edge(1,:)];
phi_extend = [phi_aud, edge(2,:)];

weight_directivity = griddata(theta_extend, phi_extend, weight_extend, theta_spk, phi_spk);
end 