function J = dhd_dy(cam, d, y, q, c)
% DHD_DY Jacobian of distored image points with respect to landmark state
% cam: camera configuration
% d: distorted point
% y: landmark state
% q: camera orientation quaternion
% J: 2x7 jacobian

p = ahp_to_euclidean(y);
R = q2R(q);
h = R' * (p - c);

J = dhd_dhu(d, cam.focal, cam.center, cam.distortion) * dhu_dh(h, cam.focal) * dh_dy(y, q);

if any(isnan(J))
  display('NaN detected in dhd_dhu!');
end

end