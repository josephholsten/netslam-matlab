function J = dh_dy(y, q)
% DH_DY Jacobian of camera-space vector with respect to landmark state

a = y(1:3);
n = y(4:6);
q = y(7);

R = q2R(q);

J = R * [zeros(3,3), q*eye(3), n];

end