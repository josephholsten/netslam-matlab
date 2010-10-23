function J = dy_dxv(g, q)
% DY_DXV: Jacobian of landmark AHP with respect to camera state
% g: estimate of landmark location
% q: camera orientation quaternion
% J: 7x13 jacobian

J = [dy_dr() dy_dq(g, q) zeros(7,6)];

end