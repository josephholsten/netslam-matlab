function predict_landmarks(model)

config = model.config;
cam = config.camera;
C = model.C;

for i = 1:model.num_landmarks
  
  p = model.landmarks(i).pos;
  d = cam.distort(cam.project(C, p));
  
  if   d(1) > 0 && d(1) < config.frame_size(1)
    && d(2) > 0 && d(2) < config.frame_size(2)
    model.landmarks(i).predicted = true;
    model.landmarks(i).prediction = d;
  else
    model.landmarks(i).predicted = false;
  end
end

end
