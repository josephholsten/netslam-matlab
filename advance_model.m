function advance_model(model, dt)

[p,q,v,w] = unpack_camera_state(model.state);

p = p + v * dt;
q = qprod(q, v2q(w * dt));

pack_camera_state(model.state, p, q, v, w);

end
