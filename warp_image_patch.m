function [I2, X, Y] = warp_image_patch(T, I1, U, V)

[I2, X, Y] = imtransform(I1, T, 'udata', U, 'vdata', V);

end