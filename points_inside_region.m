function inside = points_inside_region(points, center, region_size)

num_points = size(points, 2);
center = reshape(center,2,1);
region_size = reshape(region_size,2,1);

min = center - region_size / 2;
max = center + region_size / 2;
gt = points >= repmat(min, 1, num_points);
lt = points <= repmat(max, 1, num_points);
indices = find((ones(1,4) * [lt;gt]) > (ones(1,num_points) * 3));
inside = points(:,indices);

end