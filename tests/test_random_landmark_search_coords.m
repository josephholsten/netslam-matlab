function test_random_landmark_search_coords

model = SlamModel();
config = model.config;

margin = (config.landmark_search_size / 2) - (ones(2,1) * config.landmark_half_width + ones(2,1));

for i = 1:100
  uv = random_landmark_search_coords(model);
  assertEqual(double((uv - margin) >= zeros(2,1)), ones(2,1));
  assertEqual(double((uv + margin) < config.frame_size), ones(2,1));
end

end