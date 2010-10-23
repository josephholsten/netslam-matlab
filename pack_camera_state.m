function pack_camera_state(state, p, q, v, w)
% PACK_CAMERA_STATE pack the camera state into the state vector
% state: [cam.p, cam.q, cam.v, cam.w, {Li.ahp}]
% p: camera position (3x1)
% q: camera orientation quaternion (4x1)
% v: linear camera velocity (3x1)
% w: angular camera velocity quaternion (4x1)

state(1:3) = p;
state(4:7) = q;
state(8:10) = v;
state(11:14) = w;

end