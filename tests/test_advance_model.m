function test_advance_model
global cam_p
global cam_q
global cam_v
global cam_w
global cam_P

cam_p = [0; 0; 0];
cam_q = [1; 0; 0; 0];
cam_v = [1; 1; 1];
cam_w = [-pi/2; 0; 0];
cam_P = eye(7);

advance_model(1);

% camera pose vector
assertElementsAlmostEqual([1; 1; 1], cam_p);
% camera orientation quaternian
assertElementsAlmostEqual([sqrt(2)/2; -sqrt(2)/2; 0; 0], cam_q);
% linear camera velocity vector (v)
assertElementsAlmostEqual([1; 1; 1], cam_v);
% angular camera velocity quaternian (w)
assertElementsAlmostEqual([-pi/2; 0; 0], cam_w);
% % covariance
% P = rand(7, 7);
% P = P * P';
% assertElementsAlmostEqual(P, cam_P);

advance_model(1);

% camera pose vector
assertElementsAlmostEqual([2; 2; 2], cam_p);
% camera orientation quaternian
assertElementsAlmostEqual([0; -1; 0; 0], cam_q);
% linear camera velocity vector (v)
assertElementsAlmostEqual([1; 1; 1], cam_v);
% angular camera velocity quaternian (w)
assertElementsAlmostEqual([-pi/2; 0; 0], cam_w);
% % covariance
% P = rand(7, 7);
% P = P * P';
% assertElementsAlmostEqual(P, cam_P);
end
