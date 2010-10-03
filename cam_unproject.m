function X = cam_unproject(C, U)

global P

X = pinv(P * C) * make_homogeneous(U);

end