function h = found_predictions(model)

h = zeros(0, 1);

for i = 1:model.num_landmarks
  if model.landmarks(i).observed
    h = [h; model.landmarks(i).prediction];
  end
end

end