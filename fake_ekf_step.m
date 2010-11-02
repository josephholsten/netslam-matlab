function [x, P] = fake_ekf_step(f, x, P, h, z, Q, R)
% EKF_STEP Extended Kalman Filter for nonlinear dynamic systems (fake jacobians)
% Inputs:   f: function handle for f(x)
%           x: "a priori" state estimate
%           P: "a priori" estimated state covariance
%           h: measurement function
%           z: current measurement
%           Q: process noise covariance 
%           R: measurement noise covariance
% Output:   x: "a posteriori" state estimate
%           P: "a posteriori" state covariance
%

[fx, A] = estimate_jacobian(f, x);
[hfx, H] = estimate_jacobian(h, fx);
[x, P] = ekf_step(fx, P, hfx, z, A, H, Q, R, true);

end