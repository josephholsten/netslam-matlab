function test_advance_model

model = SlamModel();

p = [0; 0; 0];
q = [1; 0; 0; 0];
v = [1; 1; 1];
w = [-pi/2; 0; 0];

model.pack_camera_state(p, q, v, w);

[p,q,v,w] = model.unpack_camera_state();
assertElementsAlmostEqual([0; 0; 0], p);
assertElementsAlmostEqual([1; 0; 0; 0], q);
assertElementsAlmostEqual([1; 1; 1], v);
assertElementsAlmostEqual([-pi/2; 0; 0], w);

advance_model(model, 1);

[p,q,v,w] = model.unpack_camera_state();
assertElementsAlmostEqual([1; 1; 1], p);
assertElementsAlmostEqual([sqrt(2)/2; -sqrt(2)/2; 0; 0], q);
assertElementsAlmostEqual([1; 1; 1], v);
assertElementsAlmostEqual([-pi/2; 0; 0], w);

advance_model(model, 1);

[p,q,v,w] = model.unpack_camera_state();
assertElementsAlmostEqual([2; 2; 2], p);
assertElementsAlmostEqual([0; -1; 0; 0], q);
assertElementsAlmostEqual([1; 1; 1], v);
assertElementsAlmostEqual([-pi/2; 0; 0], w);

end
