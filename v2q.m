function q = v2q(v)
% V2Q: rotation vector to quaternian
% v: rotation vector
% q: rotation quaternian

theta = norm(v);
v = v / theta;
q = [cos(theta / 2); sin(theta / 2) * v];

end
