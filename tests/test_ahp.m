function test_ahp

% Test that we can go from AHP to EUCLID and back
ahp = [rand(6,1); 1];
a = ahp(1:3);
p = ahp_to_euclidean(ahp);
ahp1 = euclidean_to_ahp(p, a);
assertElementsAlmostEqual(ahp1, ahp);

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