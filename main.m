function main(model, frames, timestamps)

clear all

addpath([pwd, '/jacobians']);
addpath([pwd, '/fast-matlab-src']);

if nargin < 3
  %[model, numFrames, timestamps] = load_davison_config();
  [model, numFrames, timestamps] = load_low_iphone_config();
end

model.main_figure = figure;
image = load_frame('input', 1);
process_frame(model, image, 0);
timestamp = timestamps(1);
%print_frame_log(model, image, the_figure, 1);

for i = 2:numFrames
  image = load_frame('input', i);
  dt = timestamps(i) - timestamp;
  timestamp = timestamp + dt;
  
  advance_model(model, dt);
  
  predict_landmarks(model, dt);
  
  process_frame(model, image, dt);

%  print_frame_log(model, image, the_figure, i);
end

%write_figures_as_avi(config.figures_path, 'results.avi', size(frames,1));

end
