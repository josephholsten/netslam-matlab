function test_distortion

c = Camera(rand(1,2), rand(2,1), rand(1,5));
u = rand(2,10);
v = c.distort(u);
u1 = c.undistort(v);
assertElementsAlmostEqual(u, u1);

end