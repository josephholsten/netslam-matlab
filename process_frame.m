function process_frame(model, frame, dt)
  
% find old landmarks in frame
find_predicted_landmarks(model, frame);

% update EKF
h = found_predictions(model);
z = observations(model);
Q = model.config.process_noise;
R = model.config.observation_noise;

H = observation_jacobian(model);
A = transition_jacobian(model, dt);

x = model.state;
P = model.covariance;
[x, P] = ekf_step(x, P, h, z, A, H, Q, R);
model.state = x;
model.covariance = P;

% select new landmarks in frame
% TODO: use observed (rather than predicted) landmarks to rule out new landmark positions?
select_new_landmarks(model, frame);

end
