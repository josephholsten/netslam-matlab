function test_get_centered_region

points = reshape(1:25,5,5)';
[sub, anchor] = get_centered_region(points, [3; 3], [3; 2]);
assertEqual(sub, [12 13 14]);
assertEqual(anchor, [2; 3]);
[sub, anchor] = get_centered_region(points, [3; 3], [5; 5]);
assertEqual(sub, points);
assertEqual(anchor, [1; 1]);

end