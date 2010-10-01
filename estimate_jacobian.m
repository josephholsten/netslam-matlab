function [fx, dfdx] = estimate_jacobian(f, x)
% ESTIMATE_JACOBIAN Jacobian through complex step differentiation
% [fx dfdx] = estimate_jacobian(f,x)
% fx = f(x)
% dfdx = f'(x)

fx   = f(x);
n    = numel(x);
m    = numel(fx);
dfdx = zeros(m,n);
h    = n * eps;

for k = 1:n
    y = x;
    y(k) = y(k) + h * 1i;
    dfdx(:,k) = imag(f(y)) / h;
end

end

