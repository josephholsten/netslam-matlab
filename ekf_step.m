function [x, P] = ekf_step(f, x, P, h, z, Q, R)
% EKF_STEP Extended Kalman Filter for nonlinear dynamic systems
% Inputs:   f: function handle for f(x)
%           x: "a priori" state estimate
%           P: "a priori" estimated state covariance
%           h: fanction handle for h(x)
%           z: current measurement
%           Q: process noise covariance 
%           R: measurement noise covariance
% Output:   x: "a posteriori" state estimate
%           P: "a posteriori" state covariance
%

[fx, A]  = estimate_jacobian(f, x);      % nonlinear update and linearization at current state
P        = A * P * A' + Q;               % partial update
[hfx, H] = estimate_jacobian(h, fx);     % nonlinear measurement and linearization
P12      = P * H';                       % cross covariance
R        = chol(H * P12 + R);            % Cholesky factorization
U        = P12 / R;                      % K=U/R'; Faster because of back substitution
x        = fx + U * (R' \ (z - hfx));    % Back substitution to get state update
P        = P - U * U';                   % Covariance update, U*U'=P12/R/R'*P12'=K*P12.

end