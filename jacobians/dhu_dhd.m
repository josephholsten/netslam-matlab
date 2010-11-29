function J = dhu_dhd(d, f, c, k)
% DHU_DHD Jacobian of undistorted image coordinates
% with respsect to distorted image coordinates.
% d: distorted coordinates
% c: camera image center
% k: distortion coefficients
% J: 2x2 jacobian

p = (d - c) ./ f;
r2 = dot(p, p);
k2r2 = k(2) * r2;
D = 1 + r2 * (k(1) + k2r2);
J = D * eye(2) + 2 * (k(1) + 2 * k2r2) * ((p .* f) * (p ./ f)');

if any(isnan(J))
  display('NaN detected in dhu_dhd!');
end

end