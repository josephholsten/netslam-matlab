function J = dnormq_dq(q)
% DNORMQ_DQ Jacobian of quaternion normalization.
% q: quaternion, denormal
% J: 4x4 jacobian

n = norm(q);
J = n * (eye(4) - n * n * (q * q'));

end