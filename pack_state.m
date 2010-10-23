function pack_state(state, p, q, v, w, landmarks)
% PACK_STATE pack the state into the state vector
% state: [cam.p, cam.q, cam.v, cam.w, {Li.ahp}]
% p: camera position (3x1)
% q: camera orientation quaternion (4x1)
% v: linear camera velocity (3x1)
% w: angular camera velocity quaternion (4x1)
% landmarks: array of landmark objects

pack_camera_state(state, p, q, v, w);

j = 15;
n = 7;
for i = 1:size(landmarks)
  state(j:j+n) = landmarks(i).ahp;
  j = j + n;
end

end