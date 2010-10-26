function J = dhu_dh(u, f)
% DHU_DH Jacobian of undistored image point with respect to camera-space vector.
% u: undistorted image coordinates
% f: focal lengths
% J: 2x3 jacobian

x = u(1);
y = u(2);
fx = f(1);
fy = f(2);

J = [ fx/z, 0, -fx*x/(z*z); ...
      fy/z, 0, -fy*y/(z*z) ];

end