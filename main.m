function main(model, frames, timestamps)

the_figure = figure;
image = frames(1);
process_frame(model, image);
timestamp = timestamps(1);
print_frame_log(model, image, the_figure, 1);

for i = 2:size(frames,1)
  image = frames(i);
  dt = timestamps(i) - timestamp;
  timestamp += dt;
  advance_model(model, dt);
  predict_landmarks(model);
  process_frame(model, image, dt);
  print_frame_log(model, image, the_figure, i);
end

write_figures_as_avi(config.figures_path, 'results.avi', size(frames,1));

end
