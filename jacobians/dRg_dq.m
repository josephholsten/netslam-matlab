function J = dRg_dq(g, q)
% DRG_DQ Jacobian of a rotated vector with respect to
% a rotation quaternion.
% g: unrotated point
% q: rotation quaternion
% J: 3x4 jacobian

w = q(1);
x = q(2);
y = q(3);
z = q(4);

dR_dw = 2 * [w  -z  y; z  w -x; -y  x  w];
dR_dx = 2 * [x   y  z; y -x -w;  z  w -x];
dR_dy = 2 * [-y  x  w; x  y  z; -w  z -y];
dR_dz = 2 * [-z -w  x; w -z  y;  x  y  z];

J = [dR_dw * g, dR_dx * g, dR_dy * g, dR_dz * g];

if any(isnan(J))
  display('NaN detected in dRg_dq!');
end

end