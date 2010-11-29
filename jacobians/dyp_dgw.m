function J = dyp_dgw
% DYP_DGW: Jacobian of linear parts of landmark AHP (leaving out inverse distance)
% with respect to estimated landmark location in global frame.
% J: 6x3 jacobian

J = [zeros(3,3); eye(3)];

if any(isnan(J))
  display('NaN detected in dyp_dgw!');
end

end