function C = make_corners_from_bounds(U,V)

[UU,VV] = meshgrid(U,V);
C = [reshape(UU,1,4); reshape(VV,1,4)];

end