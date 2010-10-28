function process_frame(model, frame, dt)

if dt > 0
  % find old landmarks in frame
  find_predicted_landmarks(model, frame);

  % update EKF
  h = found_predictions(model);
  z = observations(model);

  H = observation_jacobian(model);
  A = transition_jacobian(model, dt);

  x = model.state;
  P = model.covariance;

  Q = zeros(size(x,1), size(x,1));
  Q(1:13,1:13) = model.config.process_noise;
  R = repmat(model.config.observation_noise, size(z,1), size(z,1));

  [x, P] = ekf_step(x, P, h, z, A, H, Q, R);
  model.state = x;
  model.covariance = P;
end

% select new landmarks in frame
% TODO: use observed (rather than predicted) landmarks to rule out new landmark positions?
select_new_landmarks(model, frame);

end
