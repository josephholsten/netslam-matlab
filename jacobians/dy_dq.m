function J = dy_dq(g, a, q)
% DY_DQ: Jacobian of landmark AHP with respect to camera orientation
% g: global point estimate of landmark
% a: landmark anchor coordinate
% q: camera orientation jacobian
% J: 7x4 jacobian

J = [zeros(3,4); dRg_dq(g - a, q); zeros(1,4)];

if any(isnan(J))
  display('NaN detected in dy_dq!');
end

end