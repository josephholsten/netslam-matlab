function test_jac(f, x, J_actual, tol)
% TEST_JAC: Verify a jacobian by using Matlab's fsolve() function to automatically
% compute a jacobian around a particular input value.

if nargin < 4
  tol = 1e-5;
end

y = f(x);
t = @(z) f(z) - y;
[X,FVAL,EXITFLAG,OUTPUT,J] = fsolve(t, x, optimset('Display', 'off', 'Algorithm', 'levenberg-marquardt'));
err = norm(J - J_actual);
rel = err / norm(J_actual);
if(rel > tol)
  display(J_actual);
  display(J);
  display(err);
end
assert(rel < tol);