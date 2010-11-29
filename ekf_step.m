function [x, P] = ekf_step(x, P, h, z, A, H, Q, R, do_cov_update)
% EKF_STEP Extended Kalman Filter for nonlinear dynamic systems
% Inputs:   f: function handle for f(x)
%           x: "a priori" state estimate
%           P: "a priori" estimated state covariance
%           h: predicted measurements
%           z: current measurement
%           A: state transition jacobian
%           H: measurement jacobian
%           Q: process noise covariance 
%           R: measurement noise covariance
% Output:   x: "a posteriori" state estimate
%           P: "a posteriori" state covariance
%

if size(z,1) == 0
  return;
end

if do_cov_update
  P = A * P * A' + Q;
end

%XXX
%display(H)
%display(R)

P12      = P * H';                       % cross covariance
R        = chol(H * P12 + R);            % Cholesky factorization
U        = P12 / R;                      % K=U/R'; Faster because of back substitution
x_       = U * (R' \ (z - h));
x        = x + x_;                       % Back substitution to get state update
P        = P - U * U';                   % Covariance update, U*U'=P12/R/R'*P12'=K*P12.

%display(x_); % XXX

end