function [model, numFrames, timestamps] = load_low_iphone_config

model = SlamModel();
cam = model.config.camera;

scale = 2;

Cx = 319.5  * scale;
Cy = 179.5  * scale;
fx = 788.17 * scale;
fy = 788.53 * scale;
k1 = -0.024648;
k2 = 5.276834;

cam.distortion = [k1; k2];
cam.focal = [fx; fy];
cam.center = [Cx; Cy];

model.config.camera = cam;
model.config.frame_size = [1280; 720];

numFrames = 620;
timestamps = 1:numFrames;

end