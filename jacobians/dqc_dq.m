function J = dqc_dq()
% DQC_DQ Jacobian of quaternion conjugate operator
% J: 4x4 quaternion

J = diag([1, -1, -1, -1]);

end