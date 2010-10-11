function test_points_inside_region

center = [0.5; 0.5];
points = [rand(2,100),center];
region_size = [0.6 0.6];
min = center - region_size' / 2;
max = center + region_size' / 2;
inside = points_inside_region(points, center, region_size);

assertEqual(size(inside, 1), 2);
assert(size(inside, 2) > 0);

for i = 1:size(inside,2)
  x = inside(1,i);
  y = inside(2,i);
  assert(x >= min(1));
  assert(x <= max(1));
  assert(y >= min(2));
  assert(y <= max(2));
end

end