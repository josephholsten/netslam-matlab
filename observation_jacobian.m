function J = observation_jacobian(model)
% OBSERVATION_JACOBIAN Jacobian of landmark observations with respect to
% the current model state.

[c,q,v,w] = model.unpack_camera_state();
cam = model.config.camera;
cols = 13 + model.num_landmarks * 7;
J = zeros(0, cols);

j = 1;
k = 1;
for i = 1:model.num_landmarks
  L = model.landmarks(i);
  y = model.state(k+13:k+19);
  if L.observed
    d = L.image_pos;
    p = L.pos;
    T = zeros(2, cols);
    T(:,1:13) = dhd_dxv(cam, d, q, p, c);
    T(:,k:k+6) = dhd_dy(cam, d, y, q);
    J = [J; T];
    j = j + 2;
  end
  k = k + 7;
end

end