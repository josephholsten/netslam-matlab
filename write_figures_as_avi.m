function write_figures_as_avi(path_to_figures, path_to_avi, num_frames)

avi = avifile(sprintf(path_to_avi), 'compression', 'None');

for i = 1:num_frames
  fig = fopen(sprintf('%s/%06d.fig', path_to_figures, i), 'r');
  if fig ~= -1
    frame = getframe(gcf);
    avi = addframe(avi, frame);
    fclose(fig);
    close(frame);
  end
end

avi = close(avi);

end