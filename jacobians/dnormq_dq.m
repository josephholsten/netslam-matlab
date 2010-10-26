function J = dnormq_dq(q)
% DNORMQ_DQ Jacobian of quaternion normalization.
% q: quaternion, denormal
% J: 4x4 jacobian

w = q(1);
x = q(2);
y = q(3);
z = q(4);

w2 = w * w;
x2 = x * x;
y2 = y * y;
z2 = z * z;
wx = w * x;
wy = w * y;
wz = w * z;
xy = x * y;
yz = y * z;
xz = x * z;
s = r2 + x2 + y2 + z2;
k = s ^ (-3/2);
J = [ w2, rx, ry, rz  ; ...
      rx, x2, xy, xz  ; ...
      ry, xy, y2, yz  ; ...
      rz, xz, yz, z2 ];
J = k * (diag([s s s s]) - J);

end