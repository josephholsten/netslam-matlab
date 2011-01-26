function test_jacobians

model = SlamModel();
cam = model.config.camera;
cam.focal = 2.0 * ones(2,1) + rand(2,1);
cam.projection(1:3,1:3) = diag([cam.focal;1]);
cam.distortion = [2.0e-2; -1.0e-6];

% dhu / dhd
for i = 1:10
  d = rand(2,1) * 2 - [1; 1];
  f = @(x) cam.undistort(x);
  Jreal = dhu_dhd(d, cam.focal, cam.center, cam.distortion);
  test_jac(f, d, Jreal);
end

% dhd / dhu
for i = 1:10
  u = rand(2,1) * 2 - [1; 1];
  f = @(x) cam.distort(x);
  d = f(u);
  Jreal = dhd_dhu(d, cam.focal, cam.center, cam.distortion);
  test_jac(f, u, Jreal);
end

% dnormq / dq
for i = 1:10
  q = rand(4,1);
  f = @(x) qnorm(x);
  Jreal = dnormq_dq(q);
  test_jac(f, q, Jreal);
end

% dRg / dq
for i = 1:10
  q = qnorm(rand(4,1));
  g = rand(3,1);
  f = @(x) q2R(x) * g;
  Jreal = dRg_dq(g, q);
  test_jac(f, q, Jreal);
end

% dqc / dq
for i = 1:10
  q = qnorm(rand(4,1));
  f = @(x) qconj(x);
  Jreal = dqc_dq();
  test_jac(f, q, Jreal);
end

% dgc / dhu
for i = 1:10
  u = rand(2,1) * 2 - [1; 1];
  C = eye(4);
  f = @(x) cam.unproject(C, x);
  Jreal = dgc_dhu(cam.focal);
  test_jac(f, u, Jreal);
end

% dqaqb / dqb
for i = 1:10
  qa = qnorm(rand(4,1));
  qb = qnorm(rand(4,1));
  f = @(b) qprod(qa, b);
  Jreal = dqaqb_dqb(qa);
  test_jac(f, qb, Jreal);
end

% dqwt / dw
for i = 1:10
  w = rand(3,1);
  t = rand;
  f = @(x) v2q(x * t);
  Jreal = dqwt_dw(w, t);
  test_jac(f, w, Jreal);
end

% dq / dwt
for i = 1:10
  q = qnorm(rand(4,1));
  w = rand(3,1) * 2;
  t = rand;
  f = @(x) qprod(q, v2q(x * t));
  Jreal = dq_dwt(q, w, t);
  test_jac(f, w, Jreal);
end

% dgw / dgc
for i = 1:10
  q = qnorm(rand(4,1));
  g = rand(3,1);
  f = @(x) q2R(q) * x;
  Jreal = dgw_dgc(q);
  test_jac(f, g, Jreal);
end

% dhu / dh
for i = 1:10
  p = rand(3,1);
  C = eye(4);
  f = @(x) cam.project(C, x);
  Jreal = dhu_dh(p, cam.focal);
  test_jac(f, p, Jreal);
end

% dh / dy
for i = 1:10
  a = rand(3,1);
  n = rand(3,1);
  q_ = rand;
  q = qnorm(rand(4,1));
  c = rand(3,1);
  f = @(x) q2R(q) * (ahp_to_euclidean([a; x(4:7)]) - c);
  y = [a; n; q_];
  Jreal = dh_dy(y, q);
  test_jac(f, y, Jreal, 1.0e-3);
end

% dy / dq
for i = 1:10
  g = rand(3,1);
  q = qnorm(rand(4,1));
  c = rand(3,1);
  f = @(x) [c; q2R(x) * (g - c); 1];
  Jreal = dy_dq(g, c, q);
  test_jac(f, q, Jreal);
end

% dh / dq
for i = 1:10
  p = rand(3,1);
  q = qnorm(rand(4,1));
  c = rand(3,1);
  f = @(x) q2R(qconj(x)) * (p - c);
  Jreal = dh_dq(q, p, c);
  test_jac(f, q, Jreal);
end

end