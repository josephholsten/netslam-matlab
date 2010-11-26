function [z, found] = find_landmark(model, frame, L)

pos = L.prediction;
cov = L.S;
threshold = 0.8;
template = L.patch;

plot_uncertainty_ellipse(cov, pos, 'green', 1);

[x, y, m, cc, found] = find_template_in_region(template, frame, pos, cov, threshold);
z = [x; y];

end