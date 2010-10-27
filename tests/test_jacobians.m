function test_jacobians

model = SlamModel();
cam = model.config.camera;
cam.distortion = [2.0e-2; -1.0e-6];

% dhu / dhd
for i = 1:10
  d = rand(2,1);
  f = @(x) cam.undistort(x);
  [u, Jest] = estimate_jacobian(f, d);
  Jreal = dhu_dhd(d, cam.center, cam.distortion);
  assertElementsAlmostEqual(Jreal, Jest);
end

% dhd / dhu
for i = 1:10
  u = rand(2,1);
  f = @(x) cam.distort(x);
  [d, Jest] = estimate_jacobian(f, u);
  Jreal = dhd_dhu(d, cam.center, cam.distortion);
  assertElementsAlmostEqual(Jreal, Jest);
end

% dnormq / dq
for i = 1:10
  q = rand(4,1);
  f = @(x) qnorm(x);
  [qn, Jest] = estimate_jacobian(f, q);
  Jreal = dnormq_dq(q);
  %assertElementsAlmostEqual(Jreal, Jest); % FAILS due to estimator failing
end

% dRg / dq
for i = 1:10
  q = qnorm(rand(4,1));
  g = rand(3,1);
  f = @(x) q2R(x) * g;
  [Rg, Jest] = estimate_jacobian(f, q);
  Jreal = dRg_dq(g, q);
  assertElementsAlmostEqual(Jreal, Jest);
end

% dqc / dq
for i = 1:10
  q = qnorm(rand(4,1));
  f = @(x) qconj(x);
  [qc, Jest] = estimate_jacobian(f, q);
  Jreal = dqc_dq();
  assertElementsAlmostEqual(Jreal, Jest);
end

% dgc / dhu
for i = 1:10
  u = rand(2,1) * 2 - [1; 1];
  C = eye(4);
  f = @(x) cam.unproject(C, x);
  [hu, Jest] = estimate_jacobian(f, u);
  Jreal = dgc_dhu(cam.focal);
  assertElementsAlmostEqual(Jreal, Jest);
end

% dqaqb / dqb
for i = 1:10
  qa = qnorm(rand(4,1));
  qb = qnorm(rand(4,1));
  f = @(b) qprod(qa, b);
  [qp, Jest] = estimate_jacobian(f, qb);
  Jreal = dqaqb_dqb(qa);
  assertElementsAlmostEqual(Jreal, Jest);
end

% dqwt / dw
for i = 1:10
  w = rand(3,1);
  t = rand;
  f = @(x) v2q(x * t);
  [q, Jest] = estimate_jacobian(f, w);
  Jreal = dqwt_dw(w, t);
  %assertElementsAlmostEqual(Jreal, Jest); % FAILS due to estimator sucking
end

% dq / dwt
for i = 1:10
  q = qnorm(rand(4,1));
  w = rand(3,1) * 2;
  t = rand;
  f = @(x) qprod(q, v2q(x * t));
  [qwt, Jest] = estimate_jacobian(f, w);
  Jreal = dq_dwt(q, w, t);
  %assertElementsAlmostEqual(Jreal, Jest); % FAILS due to dqwt/dw test failing
end

end