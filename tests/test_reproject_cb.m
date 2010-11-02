function test_reproject_cb

global model;

model = SlamModel();

P = [1 0 0 0; 0 1 0 0; 0 0 1 0];
I1 = checkerboard(10);

u = [-1 1];
v = [-1 1];

R1 = vrrotvec2mat([0 1 0 0]');
R2 = vrrotvec2mat([0, 1, 0, pi/4]');

t1 = [0 0 2]';
t2 = [-2 0 4]';

C1 = [R1' -R1*t1; zeros(1,3) 1];
C2 = [R2' -R2*t2; zeros(1,3) 1];

T = create_patch_transform(C1,C2,u,v);
[I2,x,y] = warp_image_patch(T,I1,u,v);

figure

subplot(1,2,1)
imshow(I1)
subplot(1,2,2)
imshow(I2)

end