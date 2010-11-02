function J = dhd_dxv(cam, d, q, p, c)
% DHD_DXV Jacobian of distorted image points with respect to camera state.

k = cam.distortion;
f = cam.focal;
u = cam.undistort(d);

R = q2R(q);
h = R' * (p - c);

dhd_dh = dhd_dhu(d, cam.focal, cam.center, k) * dhu_dh(h, f);

J = [dhd_dh * (-R'), dhd_dh * dh_dq(q, p, c), zeros(2,6)];

end