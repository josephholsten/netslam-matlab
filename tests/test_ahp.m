function test_ahp

% Test that we can go from AHP to EUCLID and back
ahp = rand(7,1);
a = ahp(1:3);
p = ahp_to_euclidean(ahp);
d = 1 / ahp(7);
ahp1 = euclidean_to_ahp(p, a, d);
ahp_part = [ahp(1:3); ahp(7)];
ahp1_part = [ahp1(1:3); ahp1(7)];
assertElementsAlmostEqual(ahp1_part, ahp_part);
dir1 = ahp(4:6);
dir2 = ahp1(4:6);
dir1 = dir1 / norm(dir1);
dir2 = dir2 / norm(dir2);
assertElementsAlmostEqual(dir1, dir2);

% Test that we can go from EUCLID to AHP and back
p = rand(3,1);
a = rand(3,1);
ahp = euclidean_to_ahp(p, a);
p1 = ahp_to_euclidean(ahp);
assertElementsAlmostEqual(p1, p);

% Test that we don't need an anchor for EUCLID -> AHP
p = rand(3,1);
ahp = euclidean_to_ahp(p);
p1 = ahp_to_euclidean(ahp);
assertElementsAlmostEqual(p1, p);

end