function write_figures_as_avi(path_to_figures, path_to_avi, num_frames)

avi = avifile(sprintf(path_to_avi), 'compression', 'None');

display('Writing figures as AVI');

for i = 1:num_frames
  fig = fopen(sprintf('%s/%06d.fig', path_to_figures, i), 'r');
  if fig ~= -1
    h = openfig(sprintf('%s/%06d.fig', path_to_figures, i));
    frame = getframe(gcf);
    avi = addframe(avi, frame);
    fclose(fig);
    close(h);
  end
  display(i);
end

avi = close(avi);

end