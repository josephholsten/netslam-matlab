function draw_search_window(model, uv)

s = model.config.landmark_search_size(1) + 2;

plot(uv(1), uv(2), 'ys', 'Markersize', s);

end