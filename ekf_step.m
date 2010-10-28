function [x, P] = ekf_step(x, P, h, z, A, H, Q, R)
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

debug = false;

if debug
  display('x: '); display(size(x));
end

if size(z,1) == 0
  return;
end

if debug
  display('z: '); display(size(z));
  display('h: '); display(size(h));
  display('A: '); display(size(A));
  display('P: '); display(size(P));
  display('H: '); display(size(H));
  display('Q: '); display(size(Q));
  display('R: '); display(size(R));
end

P        = A * P * A' + Q;               % partial update
P12      = P * H';                       % cross covariance
R        = chol(H * P12 + R);            % Cholesky factorization
U        = P12 / R;                      % K=U/R'; Faster because of back substitution

if debug
  display('R^T: '); display(size(R'));
  display('U: '); display(size(U));
end

x        = x + U * (R' \ (z - h));       % Back substitution to get state update
P        = P - U * U';                   % Covariance update, U*U'=P12/R/R'*P12'=K*P12.

end