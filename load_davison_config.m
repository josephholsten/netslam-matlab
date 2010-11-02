function [model, numFrames, timestamps] = load_davison_config

model = SlamModel();
cam = model.config.camera;

% from davison
%d =     0.0112;
%Cx =    1.7945 / d;
%Cy =    1.4433 / d;
%k1=     6.333e-2;
%k2=     1.390e-2;
%f =     2.1735 / d;
%fx = f
%fy = f

% non-fixed maual calibration
Cx = 135.392914;
Cy = 33.878120;
fx = 909.555115;
fy = 1000.639099;
k1 = -2.246161;
k2 = -7.836744;

cam.distortion = [k1; k2];
cam.focal = [fx; fy];
cam.center = [Cx; Cy];

model.config.camera = cam;

numFrames = 200;
timestamps = 1:numFrames;

end
