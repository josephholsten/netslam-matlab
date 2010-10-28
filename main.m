function main(model, frames, timestamps)

clear all

addpath([pwd, '/jacobians']);
addpath([pwd, '/fast-matlab-src']);

if nargin < 3
  model = SlamModel();
  cam = model.config.camera;
  
  d =     0.0112;
  Cx =    1.7945 / d;
  Cy =    1.4433 / d;
  k1=     6.333e-2;
  k2=     1.390e-2;
  f =     2.1735 / d;
  
  cam.distortion = [k1; k2];
  cam.focal = [f; f];
  cam.center = [Cx; Cy];
  
  model.config.camera = cam;
  
  numFrames = 200;
  timestamps = 1:numFrames;
end

the_figure = figure;
image = load_frame('input', 1);
process_frame(model, image, 0);
timestamp = timestamps(1);
print_frame_log(model, image, the_figure, 1);

for i = 2:numFrames
  image = load_frame('input', i);
  %image = frames(i);
  dt = timestamps(i) - timestamp;
  timestamp = timestamp + dt;
  advance_model(model, dt);
  predict_landmarks(model);
  process_frame(model, image, dt);
  print_frame_log(model, image, the_figure, i);
end

write_figures_as_avi(config.figures_path, 'results.avi', size(frames,1));

end
