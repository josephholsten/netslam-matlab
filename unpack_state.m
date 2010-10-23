function [p,q,v,w] = unpack_state(state, landmarks)
% UNPACK_STATE take variables out of state vector
% state: [cam.p, cam.q, cam.v, cam.w, {Li.ahp}]
% p: camera position (3x1)
% q: camera orientation quaternion (4x1)
% v: linear camera velocity (3x1)
% w: angular camera velocity quaternion (4x1)
% landmarks: array of landmark objects

[p q v w] = unpack_camera_state(state);

j = 15;
n = 7;
for i = 1:size(landmarks,2)
  landmarks(i).ahp = state(j:j+n);
  j = j + n;
end

end