function initialize_new_landmark(model, frame, uv)
% INITIALIZE_NEW_LANDMARK Given the current frame and new landmark coordinates,
% create a new landmark object and update the state and covariance.
% frame: current frame of pixels
% uv: location of landmark in frame

config = model.config;

patch = get_centered_region(frame, uv, config.landmark_width);
[p,q,v,w] = model.unpack_camera_state();

landmark = Landmark(model, patch, p, uv);
model.state = [model.state; zeros(7,1)];
model.landmarks = [model.landmarks; landmark];
model.num_landmarks = model.num_landmarks + 1;

% now we have to merge the new landmark into the covariance matrix

P = model.covariance;
Pxv = P(1:13, 1:13);
Pxvy = P(1:13, 14:end);
Pyxv = P(14:end, 1:13);
Py = P(14:end, 14:end);

%display('Merging landmark into covariance');

%display(Pxv);
%display(Pxvy);
%display(Pyxv);
%display(Py);

g = landmark.pos;
c = config.camera.center;
f = config.camera.focal;
k = config.camera.distortion;

%display(g);
%display(c);
%display(f);
%display(k);

dydxv = dy_dxv(g, p, q);
dydhd = dy_dhd(uv, q, c, f, k);

%display(dydxv);
%display(dydhd);

Pa = diag([config.std_pixel, config.std_pixel, config.std_inverse_distance]);

%display(Pa);

Pn = dydxv * Pxv * dydxv' + dydhd * Pa * dydhd';

%display(Pn);

P = [ Pxv        , Pxvy        , Pxv * dydxv';  ...
      Pyxv       , Py          , Pyxv * dydxv'; ...
      dydxv * Pxv, dydxv * Pxvy, Pn             ];

model.covariance = P;

end