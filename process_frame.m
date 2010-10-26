function process_frame(model, frame)
  
% find old landmarks in frame
if (size(predicted_landmarks, 1) > 0)
  find_predicted_landmarks(frame);

% update ekf model
  
% select new landmarks in frame
select_new_landmarks(model, frame);

end
