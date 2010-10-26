function J = DHD_DHU(d, c, k)
% DHD_DHU Jacobian of distorted image coordinates
% with respsect to undistorted image coordinates.
% d: distorted coordinates
% c: camera image center
% k: distortion coefficients
% J: 2x2 jacobian

J = inv(dhu_dhd(d, c, k));

end