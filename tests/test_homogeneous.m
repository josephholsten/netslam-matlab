function test_homogeneous

for i = 1:10
	n = floor(rand * 10) + 1;
	r = rand(n, 5);
	r1 = make_homogeneous(r);
	r2 = make_not_homogeneous(r1 * randn);
	assertElementsAlmostEqual(r2, r);
end