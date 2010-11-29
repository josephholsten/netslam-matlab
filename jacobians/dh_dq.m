function J = dh_dq(q, p, c)
% DH_DQ Jacobian of camera-space vector with respect to camera
% orientation quaternion
% q: orientation quaternion
% p: 3d point, global coordinates
% c: camera center, global coordinates
% J: 3x4 jacobian

J = dRg_dq(p - c, qconj(q)) * dqc_dq();

if any(isnan(J))
  display('NaN detected in dh_dq!');
end

end