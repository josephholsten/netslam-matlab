function h = found_predictions(model)

h = zeros(0, 2);

for i = 1:model.num_landmarks
  if model.landmarks(i).observed
    h = [h; model.landmarks(i).prediction'];
  end
end

h = reshape(h, 2 * size(h,1), 1);

end