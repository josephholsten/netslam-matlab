function J = dqwt_dw(w, t)
% DQWT_DW Jacobian of a quaternion multiplied by rotation times time,
% with respect to the rotation velocity as a vector.
% w: angular velocity vector
% t: time-step
% J: 4x3 jacobian

% MANUALLY VERIFIED (REALLY)

m = norm(w);

if m == 0
  J = zeros(4,3);
  return;
end

t2 = t / 2;
a = m * t2;
c = cos(a);
s = sin(a);
n = w / m;
sm = s / m;

J = [-t2 * s * n'; (n * n') * (t2 * c - sm) + sm * eye(3)];

if any(isnan(J))
  display('NaN detected in dqwt_dw!');
end

end