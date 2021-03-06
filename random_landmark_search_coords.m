function uv = random_landmark_search_coords(model)

config = model.config;

margin1 = ones(2,1) * (config.landmark_half_width + 1);
margin2 = config.landmark_search_size / 2;
margin = margin1 + margin2;

uv = rand(2,1) .* (config.frame_size - margin * 2) + margin;

end