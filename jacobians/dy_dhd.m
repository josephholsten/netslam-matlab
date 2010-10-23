function J = dy_dhd(d, q, c, f, k)
% DYP_DHD Jacobian of landmark state
% with respect to the distorted image coordinates of its projection.
% d: observed distorted image location of landmark
% q: camera orientation
% c: camera image center position
% f: focal lengths
% k: distortion parameters

Jp = dyp_dgw() * dgw_dgc(q) * dgc_dhu(f) * dhu_dhd(d, c, k);
J = [Jp zeros(6,1); zeros(1,2) 1];

end