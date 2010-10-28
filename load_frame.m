function frame = load_frame(frames_path, index)

fmt = 'pgm';

image = imread(sprintf('%s/%06d.%s', frames_path, index, fmt));
frame = image(:,:,1);

end