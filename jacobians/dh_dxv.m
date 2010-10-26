function J = dh_dxv(q, p, c)
% DH_DXV Jacobian of camera-space vector with respect to the
% camera state.

R = q2R(q);
dh_dc = -R';

J = [dh_dc, dh_dq(q, p, c), zeros(3,6)];

end