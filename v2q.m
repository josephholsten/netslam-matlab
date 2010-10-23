function q = v2q(v)
% V2Q convert rotation vector to jacobian
% v: rotation vector, with normal direction indicating axis of rotation and magnitude representing angle
% q: rotation jacobian

theta = norm(v);
if (theta < eps)
  q = [1 0 0 0]';
else
  n = v / theta;
  q = [cos(theta/2); sin(theta/2)*n];
end
