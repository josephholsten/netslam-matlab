function J = dhu_dh(p, f)
% DHU_DH Jacobian of undistored image point with respect to camera-space vector.
% u: undistorted image coordinates
% f: focal lengths
% J: 2x3 jacobian

x = p(1);
y = p(2);
z = p(3);
fx = f(1);
fy = f(2);

J = [ fx/z, 0, -fx*x/(z*z); ...
      0, fy/z, -fy*y/(z*z) ];

if any(isnan(J))
  display('NaN detected in dhu_dh!');
end

end