function J = dhd_dy(cam, d, y, q)
% DHD_DY Jacobian of distored image points with respect to landmark state
% cam: camera configuration
% d: distorted point
% y: landmark state
% q: camera orientation quaternion
% J: 2x7 jacobian

u = cam.undistort(d);
J = dhd_dhu(d) * dhu_dh(u, cam.focal) * dh_dy(y, q);

end