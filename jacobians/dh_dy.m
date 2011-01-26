function J = dh_dy(y, q)
% DH_DY Jacobian of camera-space vector with respect to landmark state
% y: landmark state
% q: camera orientation quaternion
% J: (3x7) jacobian

a = y(1:3); % anchor point
n = y(4:6); % direction
R = q2R(q); % rotation vector
q = y(7);   % inverse distance
d = 1 / q;  % distance

J = R * [zeros(3,3), d*eye(3), -n / (q*q)];

if any(isnan(J))
  display('NaN detected in dh_dy!');
end

end