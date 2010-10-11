function test_distortion

c = Camera(rand(1,2), rand(2,1), rand(1,5));
u = rand(2,10);
v = c.distort(u);
u1 = c.undistort(v);
assertElementsAlmostEqual(u, u1);

% Now for the fancy part!

cb = checkerboard(10);
[n m] = size(cb);
[ux, uy] = meshgrid(1:n, 1:m);
u = [reshape(ux,1,n*m); reshape(uy,1,n*m)];

c = Camera([1 1], [n m] / 2, [2.0e-4 -1.0e-8]);

v1 = c.undistort(u);
v2 = c.distort(u);

v1x = reshape(v1(1,:), n, m);
v1y = reshape(v1(2,:), n, m);
v2x = reshape(v2(1,:), n, m);
v2y = reshape(v2(2,:), n, m);

cb1 = interp2(ux, uy, cb, v1x, v1y);
cb2 = interp2(ux, uy, cb, v2x, v2y);

figure

subplot(1,3,1)
imshow(cb)

subplot(1,3,2)
imshow(cb1)

subplot(1,3,3)
imshow(cb2)

end