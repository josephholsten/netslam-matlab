function J = dgc_dhu(f)
% DGC_DHU Jacobian of camera-frame coordinates with respect to
% undistored image plane coordinates.
% f: focal lengths
% J: 3x2 jacobian

J = [inv(f(1)) 0; 0 inv(f(2)); 0 0];

if any(isnan(J))
  display('NaN detected in dgc_dhu!');
end

end