function test_jac(f, x, J_actual)
% TEST_JAC: Verify a jacobian by using Matlab's fsolve() function to automatically
% compute a jacobian around a particular input value.

y = f(x);
t = @(z) f(z) - y;
[X,FVAL,EXITFLAG,OUTPUT,J] = fsolve(t, x, optimset('Display', 'off', 'Algorithm', 'levenberg-marquardt'));
%[X,FVAL,EXITFLAG,OUTPUT,J] = fsolve(t, x, optimset('Algorithm', 'levenberg-marquardt'));
assert(norm(J - J_actual) < 1.0e-07);