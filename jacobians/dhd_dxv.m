function J = dhd_dxv(cam, d, q, p, c)
% DHD_DXV Jacobian of distorted image points with respect to camera state.

u = cam.undistort(d);
dhd_dh = dhd_dhu(d) * dhu_dh(u, cam.focal);
R = q2R(q);

J = [dhd_dh * (-R'), dhd_dh * dh_dq(q, p, c), zeros(2,6)];

end