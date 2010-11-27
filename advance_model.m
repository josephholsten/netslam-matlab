% Advance model by time dt
function advance_model(model, dt)

[p,q,v,w] = model.unpack_camera_state();

p = p + v * dt;
q = qprod(q, v2q(w * dt));

%display('New state:');
%display(p);
%display(q);
%display(v);
%display(w);

model.pack_camera_state(p, q, v, w);

model.A = transition_jacobian(model, dt);
A = model.A;

P = model.covariance;
Q = zeros(size(P,1), size(P,1));
Q(1:13,1:13) = model.config.process_noise;
model.Q = Q;

model.covariance = A * P * A' + Q;

Pnew = model.covariance;

%display('Partial covariance update:');
%A = full(A);
%P = full(P);
%display(A);
%display(P);
%display(Q);
%display(Pnew);

end
