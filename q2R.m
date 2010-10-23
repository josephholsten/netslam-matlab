function R = q2R(q)
% Q2R convert jacobian to rotation matrix
% q: jacobian
% R: 3x3 rotation matrix

w = q(1);
x = q(2);
y = q(3);
z = q(4);

w2 = 0.5*w*w;
x2 = 0.5*x*x;
y2 = 0.5*y*y;
z2 = 0.5*z*z;
xy = x*y;
xz = x*z;
yz = y*z;
wx = w*x;
wy = w*y;
wz = w*z;

R = 2 * [w2+x2-y2-z2 xy-wz xz+wy; ...
         xy+wz w2-x2+y2-z2 yz-wx; ...
         xz-wy yz+wx w2-x2-y2+z2];

end