function J = transition_jacobian(model, dt)

% TODO: trick EKF into accepting a partial mostly-zero transition jacobian

[p,q,v,w] = model.unpack_camera_state();
J = sparse(eye(size(model.state, 1)));
J(1:13,1:13) = dfxv_dxv(q, w, dt);

end