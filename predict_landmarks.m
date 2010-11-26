function predict_landmarks(model, dt)

config = model.config;
cam = config.camera;
C = model.C;

for i = 1:model.num_landmarks
  L = model.landmarks(i);
  p = L.pos;
  u = cam.project(C, p);
  d = cam.distort(u);
  L.observed = false;
  
  if   d(1) > 0 && d(1) < config.frame_size(1) ...
    && d(2) > 0 && d(2) < config.frame_size(2)
    L.predicted = true;
    L.prediction = d;
  else
    display('bad prediction:');
    display(d);
    L.predicted = false;
  end
end

prediction_jacobians(model);
P = model.covariance;

%display('In predict_landmarks:');

for i = 1:model.num_landmarks
  if L.predicted
    L = model.landmarks(i);
    H = L.H;
    S = H * P * H' + config.observation_noise;
    %display(H);
    %display(P);
    %display(S);
    L.S = S;
  end
end

end
