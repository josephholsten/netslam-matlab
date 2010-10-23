function process_frame(model, frame)

if (size(predicted_landmarks, 1) > 0)
  find_predicted_landmarks(frame);
  
select_new_landmarks(model, frame);