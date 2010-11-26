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
    end
  end
end

%if any_found
%  waitforbuttonpress;
%end

end