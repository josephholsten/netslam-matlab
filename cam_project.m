function [U] = cam_project(C, X)
% project 
global P

U = make_not_homogeneous(P * C * X);

end