function save_frame_figure(model, frame, the_figure, step)

figure(the_figure);

hold off;
imagesc(frame);
colormap gray;
hold on;

% TODO: draw stuff on frame

saveas(the_figure, sprintf('%s/%06d.fig', model.config.figures_path, step), 'fig');

end