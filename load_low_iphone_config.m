function [model, numFrames, timestamps] = load_low_iphone_config

model = SlamModel();
config = model.config;

scale = 2;

Cx = 319.5  * scale;
Cy = 179.5  * scale;
fx = 788.17 * scale;
fy = 788.53 * scale;
k1 = -0.024648;
k2 = 5.276834;

cam = Camera([fx; fy], [Cx; Cy], [k1; k2]);
config.camera = cam;
config.frame_size = [1280; 720];

model.config = config;

numFrames = 620;
timestamps = 1:numFrames;

end