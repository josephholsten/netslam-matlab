% Advance model by time dt
function advance_model(model, dt)

[p,q,v,w] = model.unpack_camera_state();

p = p + v * dt;
q = qprod(q, v2q(w * dt));

model.pack_camera_state(p, q, v, w);

end
