function test_select_new_landmarks

global config;

config = Configuration();

sz = config.frame_size(2:-1:1)';

frame = imread('fixtures/rendered.tiff');
frame = rgb2gray(frame(:,:,1:3));
frame = imresize(frame, sz);

new_landmarks = select_new_landmarks(frame, zeros(2,0));

assert(size(new_landmarks, 2) >= 5);

figure

imagesc(frame);
colormap gray;
hold on;

for i = 1:size(new_landmarks,2)
  plot(new_landmarks(1,i), new_landmarks(2,i), 's', 'Markersize', config.landmark_width);
end

hold off;