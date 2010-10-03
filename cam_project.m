function [U] = cam_project(C, X)

global P

U = make_not_homogeneous(P * C * X);

end