function J = dy_dq(g, q)
% DY_DQ: Jacobian of landmark AHP with respect to camera orientation
% g: global point estimate of landmark
% q: camera orientation jacobian
% J: 7x4 jacobian

J = [zeros(3,4); dRg_dq(g, q); zeros(1,4)];

end