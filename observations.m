function z = observations(model)

z = zeros(0, 2);

for i = 1:model.num_landmarks
  if model.landmarks(i).observed
    z = [z; model.landmarks(i).observation];
  end
end

end