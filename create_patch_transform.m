function [T] = create_patch_transform(C1,C2,U,V)

% TODO: use actual estimated landmark corner positions

corners = make_corners_from_bounds(U,V);
corners2 = cam_unproject(C1, corners);
corners2 = cam_project(C2, corners2);
T = maketform('projective', corners', corners2');

end