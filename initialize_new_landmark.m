function initialize_new_landmark(model, frame, uv)
% INITIALIZE_NEW_LANDMARK Given the current frame and new landmark coordinates,
% create a new landmark object and update the state and covariance.
% frame: current frame of pixels
% uv: location of landmark in frame

config = model.config;

patch = get_centered_region(frame, uv, config.landmark_width);
[p,q,v,w] = unpack_camera_state(model.state);

landmark = Landmark(model, patch, p, uv);
model.state = [model.state; zeros(7,1)];
model.landmarks = [model.landmarks; landmark];

% now we have to merge the new landmark into the covariance matrix

P = model.covariance;
Pxv = P(1:13, 1:13);
Pxvy = P(1:13, 14:end);
Pyxv = P(14:end, 1:13);
Py = P(14:end, 14:end);

g = landmark.pos;
c = config.camera.center;
f = config.camera.focal;
k = config.camera.distortion;

dydxv = dy_dxv(g, q);
dydhd = dy_dhd(uv, q, c, f, k);

Pa = eye(3); % diag(sig_pixel^2, sig_pixel^2, sig_inv^2)
Pn = dydxv * Pxv * dydxv' + dydhd * Pa * dydhd';

P = [ Pxv        , Pxvy        , Pxv * dydxv';  ...
      Pyxv       , Py          , Pyxv * dydxv'; ...
      dydxv * Pxv, dydxv * Pxvy, Pn             ];

model.covariance = P;

end