function find_predicted_landmarks(model, frame)

any_found = false;
config = model.config;

for i = 1:model.num_landmarks
  if model.landmarks(i).predicted
    [z, found] = find_landmark(model, frame, model.landmarks(i));
    if found
      model.landmarks(i).observed = true;
      model.landmarks(i).observation = z;
      plot(z(1), z(2), 'r+', 'Markersize', 5);
      any_found = true;
      model.landmarks(i).hits = model.landmarks(i).hits + 1;
    else
      model.landmarks(i).observed = false;
      model.landmarks(i).misses = model.landmarks(i).misses + 1;
    end
  end
end

model.throw_away_bad_landmarks();

%if any_found
%  waitforbuttonpress;
%end

end