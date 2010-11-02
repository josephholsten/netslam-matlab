function test_select_new_landmarks

model = SlamModel();
config = model.config;

sz = config.frame_size(2:-1:1)';

frame = imread('fixtures/rendered.tiff');
frame = rgb2gray(frame(:,:,1:3));
frame = imresize(frame, sz);

figure

imagesc(frame);
colormap gray;
hold on;

new_landmarks = select_new_landmarks(model, frame);
assert(size(new_landmarks, 2) >= 5);

hold off;