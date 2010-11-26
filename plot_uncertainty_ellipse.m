function plot_uncertainty_ellipse(S, uv, color, linewidth)

chi_095_2 = 5.9915;
hold on;

steps = 100;
angles = (0:2*pi/steps:2*pi)';

x = [cos(angles) sin(angles)]' * sqrt(chi_095_2);

if min(eig(S)) < 0
    S = eye(2);
    color=[0 0 0];
end

K = chol(S)';

%display('In plot_uncertainty_ellipse:');
%display(uv);
%display(x);
%display(K);

y = K * x + repmat(uv, 1, size(x,2));

h = plot(y(1,:), y(2,:));
set(h, 'Color', color, 'LineWidth', linewidth);

end