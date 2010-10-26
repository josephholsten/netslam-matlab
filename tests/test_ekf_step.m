function test_ekf_step()
%TEST_EKF_STEP Summary of this function goes here
%   Detailed explanation goes here

n = 4;                         % number of state
m = 2;                         % number of measurement
q = 0.05;                      % std of process 
r = 0.02;                      % std of measurement
Q = q^2 * eye(n);              % covariance of process
R = r^2 * eye(m);              % covariance of measurement  

f = @(x)[x(1:2)'+0.1*rand(1,2)-0.05,x(1:2)']';    % nonlinear state equations; robot takes a random walk
h = @(x)x(1:2)-x(3:4);                            % measurement equation; instantaneous velocity

s = [0 0 0 0]';                % initial state; at the origin
x = s + q * randn(n,1);        % initial state with noise
P = eye(n);                    % initial state covraiance
N = 50;                        % total dynamic steps
xV = zeros(n, N);              % estmate
sV = zeros(n, N);              % actual
zV = zeros(m, N);              % observation
hV = zeros(m, N);              % h(estimate)
PV = zeros(n, N);              % diagonal of P

for k = 1:N
  z = h(s) + r * randn;                    % measurments
  [x, P]  = fake_ekf_step(f,x,P,h,z,Q,R);  % ekf 
	sV(:,k) = s;                             % save actual state
  zV(:,k) = z;                             % save measurment
  xV(:,k) = x;                             % save estimate
  hV(:,k) = h(x);                          % save projected estimate
  PV(:,k) = diag(P);                       % save diag of P
  s = f(s) + q * randn(n, 1);              % update process 
end

M = max(n, m);

figure

for k = 1:n                                % plot results
  subplot(M, 3, k*3-2)
  plot(1:N, sV(k,:), '-', 1:N, xV(k,:), '--')
end

for k = 1:m
  subplot(M, 3, k*3-1)
  plot(1:N, zV(k,:), '-', 1:N, hV(k,:), '--')
end

for k = 1:n
	subplot(M, 3, k*3)
	plot(1:N, PV(k,:), '-')
end

end
