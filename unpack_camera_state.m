function [p,q,v,w] = unpack_camera_state(state)
% UNPACK_CAMERA_STATE take camera variables out of state vector
% state: [cam.p, cam.q, cam.v, cam.w, {Li.ahp}]
% p: camera position (3x1)
% q: camera orientation quaternion (4x1)
% v: linear camera velocity (3x1)
% w: angular camera velocity quaternion (4x1)

p = state(1:3);
q = state(4:7);
v = state(8:10);
w = state(11:13);

end