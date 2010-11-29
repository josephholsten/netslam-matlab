function J = dgw_dgc(q)
% DGW_DGC: Jacobian of point in world coordinates with respect to
% same point in local coordinates, under a rotation transform using
% the given jacobian.
% q: rotation jacobian
% J: 3x3 matrix

J = q2R(q);

if any(isnan(J))
  display('NaN detected in dgw_dgc!');
end

end