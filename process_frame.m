function process_frame(model, frame, dt)

figure(model.main_figure);

hold off;
imagesc(frame);
colormap gray;
hold on;
%waitforbuttonpress;

if dt > 0
  % find old landmarks in frame
  find_predicted_landmarks(model, frame);
  model.H = observation_jacobian(model);

  % update EKF
  h = found_predictions(model);
  z = observations(model);

  model.pack_landmarks();
  x = model.state;
  P = model.covariance;
  A = model.A;
  H = model.H;

  R = model.config.observation_noise;

  [x, P] = ekf_step(x, P, h, z, A, H, model.Q, R, false);
  
  model.state = x;
  model.covariance = P;
  
  [p,q,v,w] = model.unpack_camera_state();
  q = qnorm(q);
  model.pack_camera_state(p,q,v,w);
  
  model.unpack_landmarks();
end

% select new landmarks in frame
% TODO: use observed (rather than predicted) landmarks to rule out new landmark positions?
select_new_landmarks(model, frame);

end
