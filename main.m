configuration = ?; % ?
frames = ?; % [image, timestamp; ...]


initialize_graph(configuration);
[image, timestamp] = frames(1);
process_frame(image);

for i = 2:size(frames,1)
  image = frames(i, 1);
  dt = frames(i, 2) - timestamp;
  timestamp += dt;
  advance_model(dt);
  predict_landmarks();
  process_frame(image);
  select_active_node();
  update_graph();
  print_frame_log();
end

print_graph();