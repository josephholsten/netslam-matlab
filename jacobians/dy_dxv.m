function J = dy_dxv(g, a, q)
% DY_DXV: Jacobian of landmark AHP with respect to camera state
% g: estimate of landmark location
% c: landmark anchor coordinate
% q: camera orientation quaternion
% J: 7x13 jacobian

J = [dy_dr() dy_dq(g, a, q) zeros(7,6)];

if any(isnan(J))
  display('NaN detected in dy_dxv!');
end

end