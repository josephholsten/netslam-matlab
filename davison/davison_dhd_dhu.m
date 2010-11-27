function J = dhd_dhu(d, f, c, k)
% DHD_DHU Jacobian of distorted image coordinates (DAVISON's version)
% with respsect to undistorted image coordinates.
% d: distorted coordinates
% c: camera image center
% k: distortion coefficients
% J: 2x2 jacobian

J = inv(dhu_dhd(d, f, c, k));

end
