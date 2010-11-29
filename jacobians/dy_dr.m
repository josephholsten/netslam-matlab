function J = dy_dr
% DY_DR: Jacobian of landmark AHP with respect to camera position
% J: 7x3 jacobian

J = [eye(3); zeros(4,3)];

if any(isnan(J))
  display('NaN detected in dy_dr!');
end

end