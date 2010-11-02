function find_predicted_landmarks(model, frame)

any_found = false;

for i = 1:model.num_landmarks
  if model.landmarks(i).predicted
    [z, found] = find_landmark(model, frame, model.landmarks(i));
    if found
      plot(z(1), z(2), 'r+', 'Markersize', config.landmark_width + 2);
      any_found = true;
    end
  end
end

%if any_found
%  waitforbuttonpress;
%end

end