function C = make_corners_from_bounds(U,V)
% MAKE_CORNERS_FROM_BOUNDS Turn UL and LR positions into a set of four
% corner UV points.

[UU,VV] = meshgrid(U,V);
C = [reshape(UU,1,4); reshape(VV,1,4)];

end