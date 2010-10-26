function find_predicted_landmarks(model, frame)

for i = 1:model.num_landmarks
  if model.landmarks(i).predicted
    find_landmark(model, model.landmarks(i));
  end
end

end